
local L_1_ = getgenv().L_1_ or {}
getgenv().L_1_ = L_1_

local ProgressionModule = {}

L_1_[32] = {
        ["Snow Trooper"] = true,
        ["Winter Warrior"] = true
}
L_1_[65] = {
        ["Kingdom of Rose"] = {
                ["CFrame"] = CFrame["new"](-180, 15, 2630),
                ["Mobs"] = {
                        "Swan Pirate",
                        "Factory Staff"
                }
        },
        ["Green Zone"] = {
                ["CFrame"] = CFrame["new"](-2458, 73, -3281),
                ["Mobs"] = {
                        "Toga Warrior",
                        "Gladiator"
                }
        },
        ["Graveyard Island"] = {
                ["CFrame"] = CFrame["new"](-5434, 15, -758),
                ["Mobs"] = {
                        "Graveyard Bandits",
                        "Zombie"
                }
        },
        ["Snow Mountain"] = {
                ["CFrame"] = CFrame["new"](1347, 87, -1222),
                ["Mobs"] = {
                        "Snow Trooper",
                        "Winter Warrior"
                }
        },
        ["Hot and Cold (Cold)"] = {
                ["CFrame"] = CFrame["new"](-6026, 15, -5062),
                ["Mobs"] = {
                        "Lab Subordinate",
                        "Horned Warrior"
                }
        },
        ["Hot and Cold (Hot)"] = {
                ["CFrame"] = CFrame["new"](-5478, 15, -5240),
                ["Mobs"] = {
                        "Magma Ninja",
                        "Lava Pirate"
                }
        },
        ["Cursed Ship"] = {
                ["CFrame"] = CFrame["new"](902, 126, 33071),
                ["Mobs"] = {
                        "Ship Deckhand",
                        "Ship Engineer",
                        "Ship Steward",
                        "Ship Officer"
                }
        },
        ["Ice Castle"] = {
                ["CFrame"] = CFrame["new"](6137, 294, -6747),
                ["Mobs"] = {
                        "Arctic Warrior",
                        "Snow Lurker"
                }
        },
        ["Forgotten Island"] = {
                ["CFrame"] = CFrame["new"](-3043, 238, -10191),
                ["Mobs"] = {
                        "Sea Soldier",
                        "Water Fighter"
                }
        }
}
L_1_[98] = {
        ["Port Town"] = {
                ["CFrame"] = CFrame["new"](-290, 44, 5450),
                ["Mobs"] = {
                        "Pirate Millionaire",
                        "Pistol Billionaire"
                }
        },
        ["Hydra Island"] = {
                ["CFrame"] = CFrame["new"](5228, 604, 345),
                ["Mobs"] = {
                        "Dragon Crew Warrior",
                        "Dragon Crew Archer",
                        "Female Islander",
                        "Giant Islander",
                        "Training Dummy"
                }
        },
        ["Great Tree"] = {
                ["CFrame"] = CFrame["new"](2682, 1682, -7190),
                ["Mobs"] = {
                        "Marine Commodore",
                        "Marine Rear Admiral"
                }
        },
        ["Floating Turtle"] = {
                ["CFrame"] = CFrame["new"](-12000, 331, -8500),
                ["Mobs"] = {
                        "Forest Pirate",
                        "Mythological Pirate",
                        "Jungle Pirate",
                        "Musketeer Pirate",
                        "Fishman Raider",
                        "Fishman Captain"
                }
        },
        ["Haunted Castle"] = {
                ["CFrame"] = CFrame["new"](-9515, 142, 5536),
                ["Mobs"] = {
                        "Reborn Skeleton",
                        "Living Zombie",
                        "Demonic Soul",
                        "Posessed Mummy"
                }
        },
        ["Sea of Treats"] = {
                ["CFrame"] = CFrame["new"](-1145, 13, -14450),
                ["Mobs"] = {
                        "Peanut Scout",
                        "Peanut President",
                        "Ice Cream Commander",
                        "Cookie Crafter",
                        "Cake Guard",
                        "Baking Staff",
                        "Head Baker",
                        "Cocoa Warrior",
                        "Chocolate Bar Battler",
                        "Sweet Thief",
                        "Candy Rebel"
                }
        },
        ["Tiki Outpost"] = {
                ["CFrame"] = CFrame["new"](-16200, 90, -17300),
                ["Mobs"] = {
                        "Isle Outlaw",
                        "Island Boy",
                        "Sun-kissed Warrior",
                        "Isle Champion"
                }
        },
        ["Submerged Island"] = {
                ["CFrame"] = CFrame["new"](-3200, -10, -10000),
                ["Mobs"] = {
                        "Reef Bandit",
                        "Coral Pirate",
                        "Sea Chanter",
                        "Ocean Prophet",
                        "High Disciple",
                        "Grand Devotee"
                }
        }
}

if World1 then
        L_1_[60] = L_1_[65]
elseif World2 then
        L_1_[60] = L_1_[32]
elseif World3 then
        L_1_[60] = L_1_[98]
end

AuraSkin = function(L_468_arg0)
        local L_469_ = {}
        L_469_[2] = L_468_arg0
        L_469_[1] = {
                [1] = {
                        ["StorageName"] = L_469_[2],
                        ["Type"] = "AuraSkin",
                        ["Context"] = "Equip"
                }
        }
        (((L_1_[18]:WaitForChild("Modules")):WaitForChild("Net")):WaitForChild("RF/FruitCustomizerRF")):InvokeServer(unpack(L_469_[1]))
end

VaildColor = function(L_470_arg0)
        local L_471_ = {}
        L_471_[2] = L_470_arg0
        if L_471_[2] and L_471_[2]["BrickColor"] then
                return tostring(L_471_[2]["BrickColor"]) == "Lime green"
        end
end

HakiCalculate = function(L_472_arg0)
        local L_473_ = {}
        L_473_[1] = L_472_arg0
        L_473_[3] = {
                ["Really red"] = "Pure Red",
                ["Oyster"] = "Snow White",
                ["Hot pink"] = "Winter Sky"
        }
        if L_473_[1] and L_473_[1]["BrickColor"] then
                return L_473_[3][tostring(L_473_[1]["BrickColor"])]
        end
end

L_1_[35] = function()
        local L_444_ = {}
        L_444_[5] = game:GetService("HttpService")
        L_444_[3] = game:GetService("TeleportService")
        L_444_[2] = "https://games.roblox.com/v1/games/"
        L_444_[1] = game["PlaceId"]
        L_444_[4] = {}
        L_444_[8] = ""
        L_444_[7] = false
        repeat
                local L_445_ = {}
                L_445_[3], L_445_[2] = pcall(function()
                        return game:HttpGet(L_444_[2] .. (L_444_[1] .. ("/servers/Public?sortOrder=Asc&limit=100&cursor=" .. L_444_[8])))
                end)
                if L_445_[3] and L_445_[2] then
                        local L_446_ = {}
                        L_446_[2] = L_444_[5]:JSONDecode(L_445_[2])
                        if L_446_[2]["data"] then
                                for L_447_forvar0, L_448_forvar1 in pairs(L_446_[2]["data"]) do
                                        local L_449_ = {}
                                        L_449_[2], L_449_[1] = L_447_forvar0, L_448_forvar1
                                        if L_449_[1]["playing"] < L_449_[1]["maxPlayers"] and L_449_[1]["id"] ~= game["JobId"] then
                                                L_444_[7] = true
                                                L_444_[3]:TeleportToPlaceInstance(L_444_[1], L_449_[1]["id"])
                                                break
                                        end
                                end
                                L_444_[8] = L_446_[2]["nextPageCursor"] or ""
                        end
                end
        until not L_444_[8] or L_444_[7]
end

function Check_Eye()
        local L_530_ = {}
        L_530_[4] = workspace["Map"]["TikiOutpost"]["IslandModel"]
        L_530_[1] = {
                L_530_[4]["Eye1"],
                L_530_[4]["Eye2"],
                L_530_[4]["IslandChunks"]["E"]["Eye3"],
                L_530_[4]["IslandChunks"]["E"]["Eye4"]
        }
        L_530_[3] = 0
        for L_531_forvar0, L_532_forvar1 in ipairs(L_530_[1]) do
                local L_533_ = {}
                L_533_[2], L_533_[3] = L_531_forvar0, L_532_forvar1
                if L_533_[3] and L_533_[3]["Transparency"] ~= 1 then
                        L_530_[3] = L_530_[3] + 1
                end
        end
        L_530_[2] = L_530_[3] == 4
        return L_530_[3], L_530_[2]
end

L_1_[100] = function(L_548_arg0)
        local L_549_ = {}
        L_549_[2] = L_548_arg0
        L_549_[1] = game:GetService("VirtualInputManager")
        L_549_[1]:SendKeyEvent(true, L_549_[2], false, game)
        wait(.05)
        L_549_[1]:SendKeyEvent(false, L_549_[2], false, game)
end

L_1_[3] = function(L_550_arg0)
        local L_551_ = {}
        L_551_[4] = L_550_arg0
        L_551_[2] = L_1_[136]["Character"]
        L_551_[3] = L_1_[136]["Backpack"]
        if not(L_551_[2] and (L_551_[2]:FindFirstChild("Humanoid") and L_551_[2]["Humanoid"]["Health"] > 0)) then
                return
        end
        for L_552_forvar0, L_553_forvar1 in pairs(L_551_[3]:GetChildren()) do
                local L_554_ = {}
                L_554_[3], L_554_[2] = L_552_forvar0, L_553_forvar1
                if L_554_[2]:IsA("Tool") and L_554_[2]["ToolTip"] == L_551_[4] then
                        L_554_[2]["Parent"] = L_551_[2]
                        wait(.12)
                        for L_555_forvar0, L_556_forvar1 in ipairs({
                                "Z",
                                "X",
                                "C",
                                "V",
                                "F"
                        }) do
                                local L_557_ = {}
                                L_557_[1], L_557_[2] = L_555_forvar0, L_556_forvar1
                                if not _G["FarmPhaBinh"] then
                                        break
                                end
                                pcall(function()
                                        L_1_[100](L_557_[2])
                                end)
                                wait(.12)
                        end
                        L_554_[2]["Parent"] = L_551_[3]
                        break
                end
        end
end

L_1_[101] = {
        CFrame["new"](-16332.526367188, 158.07200622559, 1440.3249511719),
        CFrame["new"](-16288.609375, 158.16700744629, 1470.3680419922),
        CFrame["new"](-16245.412109375, 158.43699645996, 1463.3659667969),
        CFrame["new"](-16212.46875, 158.16700744629, 1466.3439941406),
        CFrame["new"](-16211.946289062, 158.07200622559, 1322.3979492188),
        CFrame["new"](-16260.921875, 154.92100524902, 1323.6159667969)
}

L_1_[59] = game:GetService("Players")
L_1_[57] = L_1_[59]["LocalPlayer"]
L_1_[80] = game:GetService("Workspace")
L_1_[56] = game:GetService("ReplicatedStorage")
L_1_[13] = L_1_[56]:WaitForChild("FishReplicated")
L_1_[27] = L_1_[13]:WaitForChild("FishingRequest")

pcall(function()
        L_1_[111] = require(L_1_[13]["FishingClient"]["Config"])
        L_1_[7] = require(L_1_[56]["Util"]["GetWaterHeightAtLocation"])
        L_1_[21] = L_1_[111]["Rod"]["MaxLaunchDistance"]
end)

L_1_[62] = game:GetService("Players")
L_1_[68] = L_1_[62]["LocalPlayer"]
L_1_[14] = game:GetService("ReplicatedStorage")

pcall(function()
        L_1_[72] = L_1_[14]["Modules"]["Net"]:WaitForChild("RF/JobsRemoteFunction")
end)

L_1_[31] = function()
        local L_723_ = {}
        L_723_[2] = L_1_[68]["PlayerGui"]:FindFirstChild("Quest") or L_1_[68]["PlayerGui"]:FindFirstChild("QuestGui")
        if L_723_[2] and (L_723_[2]:FindFirstChild("Container") and L_723_[2]["Container"]:FindFirstChild("QuestTitle")) then
                return true
        end
        return false
end

L_1_[132] = game:GetService("ReplicatedStorage")
pcall(function()
        L_1_[97] = L_1_[132]["Modules"]["Net"]:WaitForChild("RF/JobToolAbilities")
end)

function ProgressionModule.startLoops()
        task["spawn"](function()
        while task["wait"](.2) do
                local L_418_ = {}
                if not _G["AutoFarmIsland"] then
                        continue
                end
                if not _G["SelectIsland"] then
                        continue
                end
                if not L_1_[60] then
                        continue
                end
                L_418_[1] = L_1_[60][_G["SelectIsland"]]
                if not L_418_[1] then
                        continue
                end
                L_418_[3] = L_418_[1]["CFrame"]
                L_418_[2] = L_418_[1]["Mobs"]
                L_418_[5] = {}
                for L_419_forvar0, L_420_forvar1 in ipairs(L_418_[2]) do
                        local L_421_ = {}
                        L_421_[3], L_421_[1] = L_419_forvar0, L_420_forvar1
                        L_418_[5][L_421_[1]] = true
                end
                L_418_[4] = false
                for L_422_forvar0, L_423_forvar1 in pairs(workspace["Enemies"]:GetChildren()) do
                        local L_424_ = {}
                        L_424_[3], L_424_[2] = L_422_forvar0, L_423_forvar1
                        if L_418_[5][L_424_[2]["Name"]] and (L_424_[2]:FindFirstChild("Humanoid") and (L_424_[2]:FindFirstChild("HumanoidRootPart") and L_424_[2]["Humanoid"]["Health"] > 0)) then
                                L_418_[4] = true
                                repeat
                                        task["wait"]()
                                        _tp(L_424_[2]["HumanoidRootPart"]["CFrame"] * CFrame["new"](0, 10, 0))
                                        L_1_[4]["Kill"](L_424_[2], true)
                                until not _G["AutoFarmIsland"] or not L_424_[2]["Parent"] or L_424_[2]["Humanoid"]["Health"] <= 0
                        end
                end
                if not L_418_[4] then
                        _tp(L_418_[3])
                end
        end
end)

spawn(function()
        while wait(1) do
                pcall(function()
                        if _G["FarmEliteHunt"] then
                                local L_429_ = {}
                                L_429_[2] = L_1_[136]["PlayerGui"]["Main"]["Quest"]
                                L_429_[3] = L_429_[2]["Container"]["QuestTitle"]["Title"]["Text"]
                                if not L_429_[2]["Visible"] then
                                        local L_430_ = {}
                                        L_430_[2] = L_1_[18]["Remotes"]["CommF_"]:InvokeServer("EliteHunter")
                                        if L_430_[2] == nil or string["find"](L_430_[2], "Cooldown") then
                                                wait(10)
                                                return
                                        end
                                        task["wait"](1)
                                else
                                        local L_431_ = {}
                                        L_431_[2] = nil
                                        for L_432_forvar0, L_433_forvar1 in pairs({
                                                "Diablo",
                                                "Urban",
                                                "Deandre"
                                        }) do
                                                local L_434_ = {}
                                                L_434_[2], L_434_[3] = L_432_forvar0, L_433_forvar1
                                                if string["find"](L_429_[3], L_434_[3]) then
                                                        L_431_[2] = L_434_[3]
                                                        break
                                                end
                                        end
                                        if L_431_[2] then
                                                local L_435_ = {}
                                                L_435_[2] = nil
                                                for L_436_forvar0, L_437_forvar1 in pairs(L_1_[18]:GetChildren()) do
                                                        local L_438_ = {}
                                                        L_438_[2], L_438_[3] = L_436_forvar0, L_437_forvar1
                                                        if L_438_[3]["Name"] == L_431_[2] and L_438_[3]:FindFirstChild("HumanoidRootPart") then
                                                                L_435_[2] = L_438_[3]
                                                                break
                                                        end
                                                end
                                                for L_439_forvar0, L_440_forvar1 in pairs(Enemies:GetChildren()) do
                                                        local L_441_ = {}
                                                        L_441_[1], L_441_[3] = L_439_forvar0, L_440_forvar1
                                                        if L_441_[3]["Name"] == L_431_[2] and L_1_[4]["Alive"](L_441_[3]) then
                                                                L_435_[2] = L_441_[3]
                                                                break
                                                        end
                                                end
                                                if L_435_[2] and L_435_[2]:FindFirstChild("HumanoidRootPart") then
                                                        _tp(L_435_[2]["HumanoidRootPart"]["CFrame"] * CFrame["new"](0, 30, 0))
                                                        repeat
                                                                wait()
                                                                L_1_[4]["Kill"](L_435_[2], _G["FarmEliteHunt"])
                                                        until not _G["FarmEliteHunt"] or not L_435_[2]["Parent"] or L_435_[2]["Humanoid"]["Health"] <= 0 or not L_429_[2]["Visible"]
                                                else
                                                        wait(5)
                                                end
                                        else
                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("AbandonQuest")
                                        end
                                end
                        end
                end)
        end
end)

spawn(function()
        while task["wait"](1) do
                pcall(function()
                        if _G["FarmEliteH"] then
                                local L_450_ = {}
                                L_450_[2] = L_1_[136]["PlayerGui"]["Main"]["Quest"]
                                L_450_[1] = L_450_[2]["Container"]["QuestTitle"]["Title"]["Text"]
                                if not L_450_[2]["Visible"] then
                                        local L_451_ = {}
                                        L_451_[1] = L_1_[18]["Remotes"]["CommF_"]:InvokeServer("EliteHunter")
                                        if L_451_[1] == nil or string["find"](L_451_[1], "Cooldown") then
                                                L_1_[35]()
                                                return
                                        end
                                        task["wait"](1)
                                else
                                        local L_452_ = {}
                                        L_452_[1] = nil
                                        for L_453_forvar0, L_454_forvar1 in pairs({
                                                "Diablo",
                                                "Urban",
                                                "Deandre"
                                        }) do
                                                local L_455_ = {}
                                                L_455_[3], L_455_[1] = L_453_forvar0, L_454_forvar1
                                                if string["find"](L_450_[1], L_455_[1]) then
                                                        L_452_[1] = L_455_[1]
                                                        break
                                                end
                                        end
                                        if L_452_[1] then
                                                local L_456_ = {}
                                                L_456_[1] = nil
                                                for L_457_forvar0, L_458_forvar1 in pairs(L_1_[18]:GetChildren()) do
                                                        local L_459_ = {}
                                                        L_459_[1], L_459_[2] = L_457_forvar0, L_458_forvar1
                                                        if L_459_[2]["Name"] == L_452_[1] and L_459_[2]:FindFirstChild("HumanoidRootPart") then
                                                                L_456_[1] = L_459_[2]
                                                                break
                                                        end
                                                end
                                                for L_460_forvar0, L_461_forvar1 in pairs(workspace["Enemies"]:GetChildren()) do
                                                        local L_462_ = {}
                                                        L_462_[3], L_462_[1] = L_460_forvar0, L_461_forvar1
                                                        if L_462_[1]["Name"] == L_452_[1] and L_1_[4]["Alive"](L_462_[1]) then
                                                                L_456_[1] = L_462_[1]
                                                                break
                                                        end
                                                end
                                                if L_456_[1] and L_456_[1]:FindFirstChild("HumanoidRootPart") then
                                                        _tp(L_456_[1]["HumanoidRootPart"]["CFrame"] * CFrame["new"](0, 30, 0))
                                                        repeat
                                                                wait()
                                                                L_1_[4]["Kill"](L_456_[1], _G["FarmEliteH"])
                                                        until not _G["FarmEliteH"] or not L_456_[1]["Parent"] or L_456_[1]["Humanoid"]["Health"] <= 0 or not L_450_[2]["Visible"]
                                                else
                                                        task["wait"](5)
                                                        L_1_[35]()
                                                end
                                        else
                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("AbandonQuest")
                                                task["wait"](1)
                                                L_1_[35]()
                                        end
                                end
                        end
                end)
        end
end)

spawn(function()
        while wait(Sec) do
                pcall(function()
                        if _G["AutoRipIngay"] then
                                local L_465_ = {}
                                L_465_[2] = GetConnectionEnemies("rip_indra")
                                if not GetWP("Dark Dagger") or not GetIn("Valkyrie") and L_465_[2] then
                                        repeat
                                                wait()
                                                L_1_[4]["Kill"](L_465_[2], _G["AutoRipIngay"])
                                        until not _G["AutoRipIngay"] or not L_465_[2]["Parent"] or L_465_[2]["Humanoid"]["Health"] <= 0
                                else
                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("requestEntrance", Vector3["new"](-5097.93164, 316.447021, -3142.66602, -0.405007899, -4.31682743e-08, .914313197, -1.90943332e-08, 1, 3.8755779e-08, -0.914313197, -1.76180437e-09, -0.405007899))
                                        wait(.1)
                                        _tp(CFrame["new"](-5344.822265625, 423.98541259766, -2725.0930175781))
                                end
                        end
                end)
        end
end)

spawn(function()
        while wait(Sec) do
                if _G["AutoUnHaki"] then
                        pcall(function()
                                local L_474_ = {}
                                L_474_[2] = workspace["Map"]["Boat Castle"]:FindFirstChild("Summoner")
                                if L_474_[2] and L_474_[2]:FindFirstChild("Circle") then
                                        for L_475_forvar0, L_476_forvar1 in pairs((L_474_[2]:FindFirstChild("Circle")):GetChildren()) do
                                                local L_477_ = {}
                                                L_477_[1], L_477_[2] = L_475_forvar0, L_476_forvar1
                                                if L_477_[2]["Name"] == "Part" then
                                                        local L_478_ = {}
                                                        L_478_[1] = L_477_[2]:FindFirstChild("Part")
                                                        if VaildColor(L_478_[1]) == false then
                                                                AuraSkin(HakiCalculate(L_477_[2]))
                                                                repeat
                                                                        wait()
                                                                        _tp(L_477_[2]["CFrame"])
                                                                until VaildColor(L_478_[1]) == true or not _G["AutoUnHaki"]
                                                        end
                                                end
                                        end
                                end
                        end)
                end
        end
end)

spawn(function()
        while task["wait"]() do
                if _G["Auto_Cake_Prince"] and not _G["AutoRaidCastle"] then
                        pcall(function()
                                local L_482_ = {}
                                L_482_[4] = game["Players"]["LocalPlayer"]
                                L_482_[6] = L_482_[4]["Character"] and L_482_[4]["Character"]:FindFirstChild("HumanoidRootPart")
                                L_482_[3] = L_482_[4]["PlayerGui"]["Main"]["Quest"]
                                L_482_[5] = workspace["Enemies"]
                                L_482_[1] = workspace["Map"]:FindFirstChild("CakeLoaf")
                                L_482_[7] = L_482_[1] and L_482_[1]:FindFirstChild("BigMirror")
                                if not L_482_[6] then
                                        return
                                end
                                if _G["AcceptQuestC"] and (L_482_[3] and not L_482_[3]["Visible"]) then
                                        local L_483_ = {}
                                        L_483_[4] = CFrame["new"](-1927.92, 37.8, -12842.54)
                                        _tp(L_483_[4])
                                        while (L_483_[4]["Position"] - L_482_[6]["Position"])["Magnitude"] > 50 do
                                                task["wait"](.2)
                                        end
                                        L_483_[1] = math["random"](1, 4)
                                        L_483_[3] = {
                                                [1] = {
                                                        "StartQuest",
                                                        "CakeQuest2",
                                                        2
                                                },
                                                [2] = {
                                                        "StartQuest",
                                                        "CakeQuest2",
                                                        1
                                                },
                                                [3] = {
                                                        "StartQuest",
                                                        "CakeQuest1",
                                                        1
                                                },
                                                [4] = {
                                                        "StartQuest",
                                                        "CakeQuest1",
                                                        2
                                                }
                                        }
                                        pcall(function()
                                                game["ReplicatedStorage"]["Remotes"]["CommF_"]:InvokeServer(unpack(L_483_[3][L_483_[1]]))
                                        end)
                                end
                                if not L_482_[1] then
                                        _tp(CFrame["new"](-2077, 252, -12373))
                                        task["wait"](2)
                                        return
                                end
                                if L_482_[7] and (L_482_[7]["Other"]["Transparency"] == 0 or L_482_[5]:FindFirstChild("Cake Prince")) then
                                        local L_484_ = {}
                                        L_484_[1] = GetConnectionEnemies("Cake Prince")
                                        if L_484_[1] then
                                                repeat
                                                        task["wait"]()
                                                        L_1_[4]["Kill2"](L_484_[1], _G["Auto_Cake_Prince"])
                                                until not _G["Auto_Cake_Prince"] or not L_484_[1]["Parent"] or L_484_[1]["Humanoid"]["Health"] <= 0
                                        else
                                                _tp(CFrame["new"](-2151.82, 149.32, -12404.91))
                                        end
                                else
                                        local L_485_ = {}
                                        L_485_[3] = {
                                                "Cookie Crafter",
                                                "Cake Guard",
                                                "Baking Staff",
                                                "Head Baker"
                                        }
                                        L_485_[2] = GetConnectionEnemies(L_485_[3])
                                        if L_485_[2] then
                                                repeat
                                                        task["wait"]()
                                                        L_1_[4]["Kill"](L_485_[2], _G["Auto_Cake_Prince"])
                                                until not _G["Auto_Cake_Prince"] or not L_485_[2]["Parent"] or L_485_[2]["Humanoid"]["Health"] <= 0 or L_482_[7] and L_482_[7]["Other"]["Transparency"] == 0
                                        else
                                                _tp(CFrame["new"](-2077, 252, -12373))
                                        end
                                end
                        end)
                end
        end
end)

spawn(function()
        while task["wait"](2) do
                if _G["AutoSpawnCP"] then
                        pcall(function()
                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("CakePrinceSpawner")
                        end)
                end
        end
end)

spawn(function()
        while wait(.1) do
                if _G["AutoPhoenixF"] then
                        pcall(function()
                                if GetBP("Bird-Bird: Phoenix") then
                                        if L_1_[136]["Backpack"]:FindFirstChild(L_1_[136]["Data"]["DevilFruit"]["Value"]) then
                                                if (L_1_[136]["Backpack"]:FindFirstChild(L_1_[136]["Data"]["DevilFruit"]["Value"]))["Level"]["Value"] >= 400 then
                                                        _tp(CFrame["new"](-2812.7670898438, 254.80346679688, -12595.560546875))
                                                        if ((CFrame["new"](-2812.7670898438, 254.80346679688, -12595.560546875))["Position"] - L_1_[136]["Character"]["HumanoidRootPart"]["Position"])["Magnitude"] <= 10 then
                                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("SickScientist", "Check")
                                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("SickScientist", "Heal")
                                                        end
                                                end
                                        elseif L_1_[136]["Character"]:FindFirstChild(L_1_[136]["Data"]["DevilFruit"]["Value"]) then
                                                if (L_1_[136]["Character"]:FindFirstChild(L_1_[136]["Data"]["DevilFruit"]["Value"]))["Level"]["Value"] >= 400 then
                                                        _tp(CFrame["new"](-2812.7670898438, 254.80346679688, -12595.560546875))
                                                        if ((CFrame["new"](-2812.7670898438, 254.80346679688, -12595.560546875))["Position"] - L_1_[136]["Character"]["HumanoidRootPart"]["Position"])["Magnitude"] <= 10 then
                                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("SickScientist", "Check")
                                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("SickScientist", "Heal")
                                                        end
                                                end
                                        end
                                end
                        end)
                end
        end
end)

spawn(function()
        local L_514_ = {}
        L_514_[1] = game["Players"]["LocalPlayer"]
        L_514_[3] = {
                "Reborn Skeleton",
                "Living Zombie",
                "Demonic Soul",
                "Possessed Mummy"
        }
        while wait(.5) do
                if not _G["AutoFarm_Bone"] then
                        continue
                end
                pcall(function()
                        local L_515_ = {}
                        L_515_[3] = L_514_[1]["Character"]
                        L_515_[5] = L_515_[3] and L_515_[3]:FindFirstChild("HumanoidRootPart")
                        if not L_515_[5] then
                                return
                        end
                        L_515_[1] = L_514_[1]["PlayerGui"]:FindFirstChild("Main") and L_514_[1]["PlayerGui"]["Main"]:FindFirstChild("Quest")
                        L_515_[2] = GetConnectionEnemies(L_514_[3])
                        if _G["AcceptQuestB"] and (L_515_[1] and not L_515_[1]["Visible"]) then
                                local L_516_ = {}
                                L_516_[1] = CFrame["new"](-9516.99316, 172.01718, 6078.46533)
                                _tp(L_516_[1])
                                repeat
                                        wait(2)
                                until not _G["AutoFarm_Bone"] or (L_516_[1]["Position"] - L_515_[5]["Position"])["Magnitude"] <= 50
                                if not _G["AutoFarm_Bone"] then
                                        return
                                end
                                L_516_[2] = {
                                        {
                                                "StartQuest",
                                                "HauntedQuest2",
                                                2
                                        },
                                        {
                                                "StartQuest",
                                                "HauntedQuest2",
                                                1
                                        },
                                        {
                                                "StartQuest",
                                                "HauntedQuest1",
                                                1
                                        },
                                        {
                                                "StartQuest",
                                                "HauntedQuest1",
                                                2
                                        }
                                }
                                game["ReplicatedStorage"]["Remotes"]["CommF_"]:InvokeServer(unpack(L_516_[2][math["random"](1, #L_516_[2])]))
                        end
                        if L_515_[2] then
                                repeat
                                        wait()
                                        L_1_[4]["Kill"](L_515_[2], true)
                                until not _G["AutoFarm_Bone"] or not L_515_[2]["Parent"] or L_515_[2]["Humanoid"]["Health"] <= 0
                        else
                                _tp(CFrame["new"](-9495.6806640625, 453.58624267578, 5977.3486328125))
                        end
                end)
        end
end)

spawn(function()
        while wait(Sec) do
                if _G["AutoHytHallow"] then
                        pcall(function()
                                local L_521_ = {}
                                L_521_[2] = GetConnectionEnemies("Soul Reaper")
                                if L_521_[2] then
                                        repeat
                                                task["wait"]()
                                                L_1_[4]["Kill"](L_521_[2], _G["AutoHytHallow"])
                                        until L_521_[2]["Humanoid"]["Health"] <= 0 or _G["AutoHytHallow"] == false
                                else
                                        if not GetBP("Hallow Essence") then
                                                repeat
                                                        task["wait"](.1)
                                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("Bones", "Buy", 1, 1)
                                                until _G["AutoHytHallow"] == false or GetBP("Hallow Essence")
                                        else
                                                repeat
                                                        wait(.1)
                                                        _tp(CFrame["new"](-8932.322265625, 146.83154296875, 6062.55078125))
                                                until _G["AutoHytHallow"] == false or L_1_[136]["Character"]["HumanoidRootPart"]["CFrame"] == CFrame["new"](-8932.322265625, 146.83154296875, 6062.55078125)
                                                EquipWeapon("Hallow Essence")
                                        end
                                end
                        end)
                end
        end
end)

spawn(function()
        while wait(Sec) do
                pcall(function()
                        if _G["Auto_Random_Bone"] then
                                repeat
                                        task["wait"]()
                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("Bones", "Buy", 1, 1)
                                until not _G["Auto_Random_Bone"]
                        end
                end)
        end
end)

spawn(function()
        while wait(Sec) do
                if _G["TryLucky"] then
                        local L_526_ = {}
                        L_526_[1] = CFrame["new"](-8761.3154296875, 164.85829162598, 6161.1567382813)
                        if L_1_[136]["Character"]["HumanoidRootPart"]["CFrame"] ~= L_526_[1] then
                                _tp(CFrame["new"](-8761.3154296875, 164.85829162598, 6161.1567382813))
                        elseif L_1_[136]["Character"]["HumanoidRootPart"]["CFrame"] == L_526_[1] then
                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("gravestoneEvent", 1)
                        end
                end
        end
end)

spawn(function()
        while wait(Sec) do
                if _G["Praying"] then
                        local L_529_ = {}
                        L_529_[2] = CFrame["new"](-8761.3154296875, 164.85829162598, 6161.1567382813)
                        if L_1_[136]["Character"]["HumanoidRootPart"]["CFrame"] ~= L_529_[2] then
                                _tp(CFrame["new"](-8761.3154296875, 164.85829162598, 6161.1567382813))
                        elseif L_1_[136]["Character"]["HumanoidRootPart"]["CFrame"] == L_529_[2] then
                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("gravestoneEvent", 2)
                        end
                end
        end
end)

spawn(function()
        while wait(Sec) do
                if _G["FarmTyrant"] then
                        pcall(function()
                                local L_538_ = {}
                                if not L_1_[136]["Character"] then
                                        return
                                end
                                L_538_[3] = L_1_[136]["Character"]:FindFirstChild("HumanoidRootPart")
                                if not L_538_[3] then
                                        return
                                end
                                L_538_[1] = Vector3["new"](-16268.287, 152.616, 1390.773)
                                if (L_538_[3]["Position"] - L_538_[1])["Magnitude"] > 5 then
                                        _tp(CFrame["new"](L_538_[1]))
                                        repeat
                                                wait()
                                        until not _G["FarmTyrant"] or L_1_[136]["Character"] and (L_1_[136]["Character"]:FindFirstChild("HumanoidRootPart") and (L_1_[136]["Character"]["HumanoidRootPart"]["Position"] - L_538_[1])["Magnitude"] <= 5)
                                end
                                L_538_[4] = workspace["Enemies"]:FindFirstChild("Tyrant of the Skies")
                                if L_538_[4] and (L_538_[4]:FindFirstChild("Humanoid") and L_538_[4]["Humanoid"]["Health"] > 0) then
                                        repeat
                                                if not _G["FarmTyrant"] then
                                                        break
                                                end
                                                if L_1_[4] and L_1_[4]["Kill"] then
                                                        L_1_[4]["Kill"](L_538_[4], _G["FarmTyrant"])
                                                end
                                                wait()
                                        until not _G["FarmTyrant"] or not L_538_[4]["Parent"] or L_538_[4]["Humanoid"]["Health"] <= 0
                                        return
                                end
                                L_538_[5] = {
                                        "Serpent Hunter",
                                        "Skull Slayer",
                                        "Isle Champion",
                                        "Sun-kissed Warrior"
                                }
                                for L_539_forvar0, L_540_forvar1 in ipairs(L_538_[5]) do
                                        local L_541_ = {}
                                        L_541_[1], L_541_[2] = L_539_forvar0, L_540_forvar1
                                        if not _G["FarmTyrant"] then
                                                break
                                        end
                                        for L_542_forvar0, L_543_forvar1 in pairs(workspace["Enemies"]:GetChildren()) do
                                                local L_544_ = {}
                                                L_544_[2], L_544_[3] = L_542_forvar0, L_543_forvar1
                                                if not _G["FarmTyrant"] then
                                                        break
                                                end
                                                if L_544_[3] and (L_544_[3]["Name"] == L_541_[2] and (L_544_[3]:FindFirstChild("HumanoidRootPart") and (L_544_[3]:FindFirstChild("Humanoid") and L_544_[3]["Humanoid"]["Health"] > 0))) then
                                                        if (L_538_[3]["Position"] - L_544_[3]["HumanoidRootPart"]["Position"])["Magnitude"] > 5000 then
                                                                local L_545_ = {}
                                                                _tp(L_544_[3]["HumanoidRootPart"]["CFrame"] * CFrame["new"](0, 30, 0))
                                                                L_545_[2] = tick()
                                                                repeat
                                                                        wait()
                                                                        L_538_[3] = L_1_[136]["Character"] and L_1_[136]["Character"]:FindFirstChild("HumanoidRootPart")
                                                                until not _G["FarmTyrant"] or not L_538_[3] or (L_538_[3]["Position"] - L_544_[3]["HumanoidRootPart"]["Position"])["Magnitude"] <= 6 or tick() - L_545_[2] > 8
                                                        end
                                                        repeat
                                                                if not _G["FarmTyrant"] then
                                                                        break
                                                                end
                                                                if L_1_[4] and L_1_[4]["Kill"] then
                                                                        L_1_[4]["Kill"](L_544_[3], _G["FarmTyrant"])
                                                                end
                                                                wait()
                                                        until not _G["FarmTyrant"] or not L_544_[3]["Parent"] or L_544_[3]["Humanoid"]["Health"] <= 0
                                                end
                                        end
                                end
                        end)
                end
        end
end)

spawn(function()
        pcall(function()
                (game:GetService("RunService"))["Stepped"]:Connect(function()
                        if (getgenv())["NoClip"] then
                                for L_695_forvar0, L_696_forvar1 in pairs(game["Players"]["LocalPlayer"]["Character"]:GetDescendants()) do
                                        local L_697_ = {}
                                        L_697_[1], L_697_[2] = L_695_forvar0, L_696_forvar1
                                        if L_697_[2]:IsA("BasePart") or L_697_[2]:IsA("Part") then
                                                L_697_[2]["CanCollide"] = false
                                        end
                                end
                        end
                end)
        end)
end)

spawn(function()
        while wait() do
                pcall(function()
                        if (getgenv())["HopServerAdmin"] then
                                for L_690_forvar0, L_691_forvar1 in pairs(game["Players"]:GetPlayers()) do
                                        local L_692_ = {}
                                        L_692_[2], L_692_[3] = L_690_forvar0, L_691_forvar1
                                        L_692_[4] = {
                                                "red_game43",
                                                "rip_indra",
                                                "Axiore",
                                                "Polkster",
                                                "wenlocktoad",
                                                "Daigrock",
                                                "toilamvidamme",
                                                "oofficialnoobie",
                                                "Uzoth",
                                                "Azarth",
                                                "arlthmetic",
                                                "Death_King",
                                                "Lunoven",
                                                "TheGreateAced",
                                                "rip_fud",
                                                "drip_mama",
                                                "layandikit12",
                                                "Hingoi"
                                        }
                                        if table["find"](L_692_[4], L_692_[3]["Name"]) then
                                                Hop()
                                        end
                                end
                        end
                end)
        end
end)

spawn(function()
        while wait(Sec) do
                pcall(function()
                        if _G["Auto_Melee"] then
                                statsSetings("Melee", pSats)
                        end
                end)
        end
end)

spawn(function()
        while wait(Sec) do
                pcall(function()
                        if _G["Auto_Sword"] then
                                statsSetings("Sword", pSats)
                        end
                end)
        end
end)

spawn(function()
        while wait(Sec) do
                pcall(function()
                        if _G["Auto_Gun"] then
                                statsSetings("Gun", pSats)
                        end
                end)
        end
end)

spawn(function()
        while wait(Sec) do
                pcall(function()
                        if _G["Auto_DevilFruit"] then
                                statsSetings("Devil", pSats)
                        end
                end)
        end
end)

spawn(function()
        while wait(Sec) do
                pcall(function()
                        if _G["Auto_Defense"] then
                                statsSetings("Defense", pSats)
                        end
                end)
        end
end)

task["spawn"](function()
        while task["wait"](2) do
                if _G["AutoBuyBait"] and _G["SelectedBait"] then
                        pcall(function()
                                L_1_[64]["RFCraft"]:InvokeServer("Craft", _G["SelectedBait"], {})
                        end)
                end
        end
end)

task["spawn"](function()
        while task["wait"](.5) do
                if _G["AutoFishing"] then
                        pcall(function()
                                local L_718_ = {}
                                L_718_[3] = L_1_[57]["Character"] or L_1_[57]["CharacterAdded"]:Wait()
                                L_718_[2] = L_718_[3]:FindFirstChild("HumanoidRootPart")
                                if not L_718_[2] then
                                        return
                                end
                                L_718_[1] = L_718_[3]:FindFirstChildOfClass("Tool")
                                if _G["SelectedRod"] and (not L_718_[1] or L_718_[1]["Name"] ~= _G["SelectedRod"]) then
                                        local L_719_ = {}
                                        L_719_[2] = L_1_[57]["Backpack"]:FindFirstChild(_G["SelectedRod"])
                                        if L_719_[2] then
                                                L_718_[3]["Humanoid"]:EquipTool(L_719_[2])
                                                L_718_[1] = L_719_[2]
                                        end
                                end
                                if L_718_[1] then
                                        local L_720_ = {}
                                        L_720_[3] = L_1_[7](L_718_[2]["Position"])
                                        L_720_[5], L_720_[6] = L_1_[80]:FindPartOnRayWithIgnoreList(Ray["new"](L_718_[3]["Head"]["Position"], L_718_[2]["CFrame"]["LookVector"] * L_1_[21]), {
                                                L_718_[3],
                                                L_1_[80]["Characters"],
                                                L_1_[80]["Enemies"]
                                        })
                                        L_720_[7] = L_720_[6] and Vector3["new"](L_720_[6]["X"], math["max"](L_720_[6]["Y"], L_720_[3]), L_720_[6]["Z"])
                                        L_720_[4] = L_718_[1]:GetAttribute("State")
                                        L_720_[1] = L_718_[1]:GetAttribute("ServerState")
                                        if L_720_[7] and (L_720_[4] == "ReeledIn" or L_720_[1] == "ReeledIn") then
                                                L_1_[27]:InvokeServer("StartCasting")
                                                task["wait"]()
                                                L_1_[27]:InvokeServer("CastLineAtLocation", L_720_[7], 100, true)
                                        elseif L_720_[1] == "Biting" then
                                                L_1_[27]:InvokeServer("Catching", true)
                                                task["wait"](.1)
                                                L_1_[27]:InvokeServer("Catch", 1)
                                        end
                                end
                        end)
                end
        end
end)

task["spawn"](function()
        while task["wait"](1) do
                if _G["AutoFishingQuest"] then
                        pcall(function()
                                if not L_1_[31]() then
                                        L_1_[72]:InvokeServer("FishingNPC", "Angler", "AskQuest")
                                end
                        end)
                end
        end
end)

task["spawn"](function()
        while task["wait"](5) do
                if _G["AutoQuestComplete"] then
                        pcall(function()
                                L_1_[64]["RFJobsRemoteFunction"]:InvokeServer("FishingNPC", "FinishQuest")
                        end)
                end
        end
end)

task["spawn"](function()
        while task["wait"](5) do
                if _G["AutoSellFish"] then
                        pcall(function()
                                L_1_[64]["RFJobsRemoteFunction"]:InvokeServer("FishingNPC", "SellFish")
                        end)
                end
        end
end)

task["spawn"](function()
        while task["wait"](.5) do
                if _G["AutoSkillZ"] then
                        pcall(function()
                                L_1_[97]:InvokeServer("Z", true)
                        end)
                end
        end
end)

spawn(function()
        while wait(Sec) do
                pcall(function()
                        if _G["TravelDres"] then
                                if L_1_[45]["Data"]["Level"]["Value"] >= 700 then
                                        if workspace["Map"]["Ice"]["Door"]["CanCollide"] == true and workspace["Map"]["Ice"]["Door"]["Transparency"] == 0 then
                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("DressrosaQuestProgress", "Detective")
                                                EquipWeapon("Key")
                                                repeat
                                                        wait()
                                                        _tp(CFrame["new"](1347.7124, 37.3751602, -1325.6488))
                                                until not _G["TravelDres"] or Root["Position"] == (CFrame["new"](1347.7124, 37.3751602, -1325.6488))["Position"]
                                        elseif workspace["Map"]["Ice"]["Door"]["CanCollide"] == false and workspace["Map"]["Ice"]["Door"]["Transparency"] == 1 then
                                                if Enemies:FindFirstChild("Ice Admiral") then
                                                        for L_732_forvar0, L_733_forvar1 in pairs(Enemies:GetChildren()) do
                                                                local L_734_ = {}
                                                                L_734_[1], L_734_[2] = L_732_forvar0, L_733_forvar1
                                                                if L_734_[2]["Name"] == "Ice Admiral" and L_1_[4]["Alive"](L_734_[2]) then
                                                                        repeat
                                                                                task["wait"]()
                                                                                L_1_[4]["Kill"](L_734_[2], _G["TravelDres"])
                                                                        until _G["TravelDres"] == false or L_734_[2]["Humanoid"]["Health"] <= 0
                                                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("TravelDressrosa")
                                                                end
                                                        end
                                                else
                                                        _tp(CFrame["new"](1347.7124, 37.3751602, -1325.6488))
                                                end
                                        else
                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("TravelDressrosa")
                                        end
                                end
                        end
                end)
        end
end)

spawn(function()
        while wait(Sec) do
                pcall(function()
                        if _G["AutoZou"] then
                                if L_1_[45]["Data"]["Level"]["Value"] >= 1500 then
                                        if L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BartiloQuestProgress", "Bartilo") == 3 then
                                                if (L_1_[18]["Remotes"]["CommF_"]:InvokeServer("GetUnlockables"))["FlamingoAccess"] ~= nil then
                                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("F_", "TravelZou")
                                                        if L_1_[18]["Remotes"]["CommF_"]:InvokeServer("ZQuestProgress", "Check") == 0 then
                                                                local L_737_ = {}
                                                                L_737_[2] = GetConnectionEnemies("rip_indra")
                                                                if L_737_[2] then
                                                                        repeat
                                                                                wait()
                                                                                L_1_[4]["Kill"](L_737_[2], _G["AutoZou"])
                                                                        until not _G["AutoZou"] or not L_737_[2]["Parent"] or L_737_[2]["Humanoid"]["Health"] <= 0
                                                                        Check = 2
                                                                        repeat
                                                                                wait()
                                                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("F_", "TravelZou")
                                                                        until Check == 1
                                                                else
                                                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("F_", "ZQuestProgress", "Check")
                                                                        wait(.1)
                                                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("F_", "ZQuestProgress", "Begin")
                                                                end
                                                        elseif L_1_[18]["Remotes"]["CommF_"]:InvokeServer("ZQuestProgress", "Check") == 1 then
                                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("F_", "TravelZou")
                                                        else
                                                                local L_738_ = {}
                                                                L_738_[1] = GetConnectionEnemies("Don Swan")
                                                                if L_738_[1] then
                                                                        repeat
                                                                                wait()
                                                                                L_1_[4]["Kill"](L_738_[1], _G["AutoZou"])
                                                                        until not _G["AutoZou"] or not L_738_[1]["Parent"] or L_738_[1]["Humanoid"]["Health"] <= 0
                                                                end
                                                        end
                                                end
                                        end
                                end
                        end
                end)
        end
end)

spawn(function()
        while wait(Sec) do
                if _G["Tp_LgS"] then
                        pcall(function()
                                for L_842_forvar0, L_843_forvar1 in pairs(L_1_[18]["NPCs"]:GetChildren()) do
                                        local L_844_ = {}
                                        L_844_[2], L_844_[1] = L_842_forvar0, L_843_forvar1
                                        if L_844_[1]["Name"] == "Legendary Sword Dealer " then
                                                _tp(L_844_[1]["HumanoidRootPart"]["CFrame"])
                                        end
                                end
                        end)
                end
        end
end)

spawn(function()
        while wait(Sec) do
                if _G["AutoPole"] then
                        pcall(function()
                                local L_847_ = {}
                                L_847_[2] = GetConnectionEnemies("Thunder God")
                                if L_847_[2] then
                                        repeat
                                                task["wait"]()
                                                L_1_[4]["Kill"](L_847_[2], _G["AutoPole"])
                                        until not _G["AutoPole"] or not L_847_[2]["Parent"] or L_847_[2]["Humanoid"]["Health"] <= 0
                                else
                                        _tp(CFrame["new"](-7994.984375, 5761.025390625, -2088.6479492188))
                                end
                        end)
                end
        end
end)

spawn(function()
        while wait(Sec) do
                pcall(function()
                        if _G["AutoPoleV2"] then
                                if not GetBP("Pole (1st Form)") then
                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("LoadItem", "Pole (1st Form)")
                                end
                                if not GetBP("Pole (2nd Form)") then
                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("LoadItem", "Pole (2nd Form)")
                                end
                                if GetBP("Pole (1st Form)") and (GetBP("Pole (1st Form)"))["Level"]["Value"] <= 179 then
                                        _G["Level"] = true
                                elseif GetBP("Pole (1st Form)") and (GetBP("Pole (1st Form)"))["Level"]["Value"] >= 180 then
                                        _G["Level"] = false
                                end
                                if not GetBP("Rumble Fruit") then
                                        return
                                end
                                if (GetBP("Rumble Fruit"))["AwakenedMoves"]:FindFirstChild("Z") and ((GetBP("Rumble Fruit"))["AwakenedMoves"]:FindFirstChild("X") and ((GetBP("Rumble Fruit"))["AwakenedMoves"]:FindFirstChild("C") and ((GetBP("Rumble Fruit"))["AwakenedMoves"]:FindFirstChild("V") and (GetBP("Rumble Fruit"))["AwakenedMoves"]:FindFirstChild("F")))) then
                                        _G["SelectChip"] = nil
                                        _G["Raiding"] = false
                                        _G["Auto_Awakener"] = false
                                        if L_1_[45]["Data"]["Fragments"]["Value"] >= 5000 then
                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("Thunder God", "Talk")
                                                wait(Sec)
                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("Thunder God", "Sure")
                                        end
                                elseif L_1_[18]["Remotes"]["CommF_"]:InvokeServer("Awakener", "Check") == nil or L_1_[18]["Remotes"]["CommF_"]:InvokeServer("Awakener", "Check") == 0 then
                                        local L_850_ = {}
                                        _G["SelectChip"] = "Rumble"
                                        L_850_[1] = L_1_[18]["Remotes"]["CommF_"]:InvokeServer("RaidsNpc", "Select", _G["SelectChip"])
                                        if L_850_[1] then
                                                L_850_[1]:Stop()
                                        end
                                        _G["Raiding"] = true
                                        _G["Auto_Awakener"] = true
                                end
                        end
                end)
        end
end)

spawn(function()
        while wait(.2) do
                pcall(function()
                        if _G["AutoSaw"] then
                                local L_853_ = {}
                                L_853_[2] = GetConnectionEnemies("The Saw")
                                if L_853_[2] then
                                        repeat
                                                task["wait"]()
                                                L_1_[4]["Kill"](L_853_[2], _G["AutoSaw"])
                                        until _G["AutoSaw"] == false or L_853_[2]["Humanoid"]["Health"] <= 0
                                else
                                        _tp(CFrame["new"](-784.89715576172, 72.427383422852, 1603.5822753906))
                                end
                        end
                end)
        end
end)

spawn(function()
        while wait(.2) do
                pcall(function()
                        if _G["AutoSaber"] and (L_1_[45]["Data"]["Level"]["Value"] >= 200 and (not L_1_[45]["Backpack"]:FindFirstChild("Saber") and not L_1_[45]["Character"]:FindFirstChild("Saber"))) then
                                if workspace["Map"]["Jungle"]["Final"]["Part"]["Transparency"] == 0 then
                                        if workspace["Map"]["Jungle"]["QuestPlates"]["Door"]["Transparency"] == 0 then
                                                if ((CFrame["new"](-1612.55884, 36.9774132, 148.719543, .37091279, 3.0717151e-09, -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, .928667724, -4.39869794e-08, .37091279))["Position"] - L_1_[45]["Character"]["HumanoidRootPart"]["Position"])["Magnitude"] <= 100 then
                                                        _tp(L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"])
                                                        wait(.5)
                                                        L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"] = workspace["Map"]["Jungle"]["QuestPlates"]["Plate1"]["Button"]["CFrame"]
                                                        wait(.5)
                                                        L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"] = workspace["Map"]["Jungle"]["QuestPlates"]["Plate2"]["Button"]["CFrame"]
                                                        wait(.5)
                                                        L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"] = workspace["Map"]["Jungle"]["QuestPlates"]["Plate3"]["Button"]["CFrame"]
                                                        wait(.5)
                                                        L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"] = workspace["Map"]["Jungle"]["QuestPlates"]["Plate4"]["Button"]["CFrame"]
                                                        wait(.5)
                                                        L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"] = workspace["Map"]["Jungle"]["QuestPlates"]["Plate5"]["Button"]["CFrame"]
                                                        wait(.5)
                                                else
                                                        _tp(CFrame["new"](-1612.55884, 36.9774132, 148.719543, .37091279, 3.0717151e-09, -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, .928667724, -4.39869794e-08, .37091279))
                                                end
                                        else
                                                if workspace["Map"]["Desert"]["Burn"]["Part"]["Transparency"] == 0 then
                                                        if L_1_[45]["Backpack"]:FindFirstChild("Torch") or L_1_[45]["Character"]:FindFirstChild("Torch") then
                                                                EquipWeapon("Torch")
                                                                firetouchinterest(L_1_[45]["Character"]["Torch"]["Handle"], workspace["Map"]["Desert"]["Burn"]["Fire"], 0)
                                                                firetouchinterest(L_1_[45]["Character"]["Torch"]["Handle"], workspace["Map"]["Desert"]["Burn"]["Fire"], 1)
                                                                _tp(CFrame["new"](1114.61475, 5.04679728, 4350.22803, -0.648466587, -1.28799094e-09, .761243105, -5.70652914e-10, 1, 1.20584542e-09, -0.761243105, 3.47544882e-10, -0.648466587))
                                                        else
                                                                _tp(CFrame["new"](-1610.00757, 11.5049858, 164.001587, .984807551, -0.167722285, -0.0449818149, .17364943, .951244235, .254912198, 3.42372805e-05, -0.258850515, .965917408))
                                                        end
                                                else
                                                        if L_1_[18]["Remotes"]["CommF_"]:InvokeServer("ProQuestProgress", "SickMan") ~= 0 then
                                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("ProQuestProgress", "GetCup")
                                                                wait(.5)
                                                                EquipWeapon("Cup")
                                                                wait(.5)
                                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("ProQuestProgress", "FillCup", L_1_[45]["Character"]["Cup"])
                                                                wait(Sec)
                                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("ProQuestProgress", "SickMan")
                                                        else
                                                                if L_1_[18]["Remotes"]["CommF_"]:InvokeServer("ProQuestProgress", "RichSon") == nil then
                                                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("ProQuestProgress", "RichSon")
                                                                elseif L_1_[18]["Remotes"]["CommF_"]:InvokeServer("ProQuestProgress", "RichSon") == 0 then
                                                                        if workspace["Enemies"]:FindFirstChild("Mob Leader") or L_1_[18]:FindFirstChild("Mob Leader") then
                                                                                _tp(CFrame["new"](-2967.59521, -4.91089821, 5328.70703, .342208564, -0.0227849055, .939347804, .0251603816, .999569714, .0150796166, -0.939287126, .0184739735, .342634559))
                                                                                for L_856_forvar0, L_857_forvar1 in pairs(workspace["Enemies"]:GetChildren()) do
                                                                                        local L_858_ = {}
                                                                                        L_858_[2], L_858_[3] = L_856_forvar0, L_857_forvar1
                                                                                        if L_858_[3]["Name"] == "Mob Leader" and L_1_[4]["Alive"](L_858_[3]) then
                                                                                                repeat
                                                                                                        task["wait"]()
                                                                                                        L_1_[4]["Kill"](L_858_[3], _G["AutoSaber"])
                                                                                                until L_858_[3]["Humanoid"]["Health"] <= 0 or _G["AutoSaber"] == false
                                                                                        end
                                                                                end
                                                                        end
                                                                elseif L_1_[18]["Remotes"]["CommF_"]:InvokeServer("ProQuestProgress", "RichSon") == 1 then
                                                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("ProQuestProgress", "RichSon")
                                                                        EquipWeapon("Relic")
                                                                        _tp(CFrame["new"](-1404.91504, 29.9773273, 3.80598116, .876514494, 5.66906877e-09, .481375456, 2.53851997e-08, 1, -5.79995607e-08, -0.481375456, 6.30572643e-08, .876514494))
                                                                end
                                                        end
                                                end
                                        end
                                else
                                        if workspace["Enemies"]:FindFirstChild("Saber Expert") or L_1_[18]:FindFirstChild("Saber Expert") then
                                                for L_859_forvar0, L_860_forvar1 in pairs(workspace["Enemies"]:GetChildren()) do
                                                        local L_861_ = {}
                                                        L_861_[2], L_861_[1] = L_859_forvar0, L_860_forvar1
                                                        if L_861_[1]["Name"] == "Saber Expert" and L_1_[4]["Alive"](L_861_[1]) then
                                                                repeat
                                                                        task["wait"]()
                                                                        L_1_[4]["Kill"](L_861_[1], _G["AutoSaber"])
                                                                until L_861_[1]["Humanoid"]["Health"] <= 0 or _G["AutoSaber"] == false
                                                                if L_861_[1]["Humanoid"]["Health"] <= 0 then
                                                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("ProQuestProgress", "PlaceRelic")
                                                                end
                                                        end
                                                end
                                        else
                                                _tp(CFrame["new"](-1401.85046, 29.9773273, 8.81916237, .85820812, 8.76083845e-08, .513301849, -8.55007443e-08, 1, -2.77243419e-08, -0.513301849, -2.00944328e-08, .85820812))
                                        end
                                end
                        end
                end)
        end
end)

spawn(function()
        while wait(.2) do
                if _G["AutoColShad"] then
                        pcall(function()
                                local L_864_ = {}
                                L_864_[2] = GetConnectionEnemies("Cyborg")
                                if L_864_[2] then
                                        repeat
                                                task["wait"]()
                                                L_1_[4]["Kill"](L_864_[2], _G["AutoColShad"])
                                        until _G["AutoColShad"] == false or not L_864_[2]["Parent"] or L_864_[2]["Humanoid"]["Health"] <= 0
                                else
                                        _tp(CFrame["new"](6094.0249023438, 73.770050048828, 3825.7348632813))
                                end
                        end)
                end
        end
end)

spawn(function()
        while task["wait"](Sec) do
                pcall(function()
                        if _G["AutoGetUsoap"] then
                                for L_867_forvar0, L_868_forvar1 in pairs(workspace["Characters"]:GetChildren()) do
                                        local L_869_ = {}
                                        L_869_[3], L_869_[2] = L_867_forvar0, L_868_forvar1
                                        if L_869_[2]["Name"] ~= L_1_[45]["Name"] then
                                                if L_869_[2]["Humanoid"]["Health"] > 0 and (L_869_[2]:FindFirstChild("HumanoidRootPart") and (L_869_[2]["Parent"] and (Root["Position"] - L_869_[2]["HumanoidRootPart"]["Position"])["Magnitude"] <= 230)) then
                                                        repeat
                                                                task["wait"]()
                                                                EquipWeapon(_G["SelectWeapon"])
                                                                _tp(L_869_[2]["HumanoidRootPart"]["CFrame"] * CFrame["new"](1, 1, 2))
                                                        until _G["AutoGetUsoap"] == false or L_869_[2]["Humanoid"]["Health"] <= 0 or not L_869_[2]["Parent"] or not L_869_[2]:FindFirstChild("HumanoidRootPart") or not L_869_[2]:FindFirstChild("Humanoid")
                                                end
                                        end
                                end
                        end
                end)
        end
end)

spawn(function()
        while wait(.2) do
                pcall(function()
                        if _G["obsFarm"] then
                                L_1_[18]["Remotes"]["CommE"]:FireServer("Ken", true)
                                if L_1_[45]:GetAttribute("KenDodgesLeft") == 0 then
                                        KenTest = false
                                elseif L_1_[45]:GetAttribute("KenDodgesLeft") > 0 then
                                        L_1_[18]["Remotes"]["CommE"]:FireServer("Ken", true)
                                        KenTest = true
                                end
                        end
                end)
        end
end)

spawn(function()
        while wait(.2) do
                pcall(function()
                        if _G["obsFarm"] then
                                if World1 then
                                        if workspace["Enemies"]:FindFirstChild("Galley Captain") then
                                                if KenTest then
                                                        repeat
                                                                wait()
                                                                L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"] = (workspace["Enemies"]:FindFirstChild("Galley Captain"))["HumanoidRootPart"]["CFrame"] * CFrame["new"](3, 0, 0)
                                                        until _G["obsFarm"] == false or KenTest == false
                                                else
                                                        repeat
                                                                wait()
                                                                L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"] = (workspace["Enemies"]:FindFirstChild("Galley Captain"))["HumanoidRootPart"]["CFrame"] * CFrame["new"](0, 50, 0)
                                                        until _G["obsFarm"] == false or KenTest
                                                end
                                        else
                                                _tp(CFrame["new"](5533.29785, 88.1079102, 4852.3916))
                                        end
                                elseif World2 then
                                        if workspace["Enemies"]:FindFirstChild("Lava Pirate") then
                                                if KenTest then
                                                        repeat
                                                                wait()
                                                                L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"] = (workspace["Enemies"]:FindFirstChild("Lava Pirate"))["HumanoidRootPart"]["CFrame"] * CFrame["new"](3, 0, 0)
                                                        until _G["obsFarm"] == false or KenTest == false
                                                else
                                                        repeat
                                                                wait()
                                                                L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"] = (workspace["Enemies"]:FindFirstChild("Lava Pirate"))["HumanoidRootPart"]["CFrame"] * CFrame["new"](0, 50, 0)
                                                        until _G["obsFarm"] == false or KenTest
                                                end
                                        else
                                                _tp(CFrame["new"](-5478.39209, 15.9775667, -5246.9126))
                                        end
                                elseif World3 then
                                        if workspace["Enemies"]:FindFirstChild("Venomous Assailant") then
                                                if KenTest then
                                                        repeat
                                                                wait()
                                                                _tp((workspace["Enemies"]:FindFirstChild("Venomous Assailant"))["HumanoidRootPart"]["CFrame"] * CFrame["new"](3, 0, 0))
                                                        until _G["obsFarm"] == false or KenTest == false
                                                else
                                                        repeat
                                                                wait()
                                                                _tp((workspace["Enemies"]:FindFirstChild("Venomous Assailant"))["HumanoidRootPart"]["CFrame"] * CFrame["new"](0, 50, 0))
                                                        until _G["obsFarm"] == false or KenTest
                                                end
                                        else
                                                _tp(CFrame["new"](4530.3540039063, 656.75695800781, -131.60952758789))
                                        end
                                end
                        end
                end)
        end
end)

spawn(function()
        while wait(Sec) do
                if _G["AutoKenVTWO"] then
                        pcall(function()
                                local L_960_ = {}
                                L_960_[1] = CFrame["new"](-12444.78515625, 332.40396118164, -7673.1806640625)
                                L_960_[5] = "Kuy"
                                L_960_[3] = CFrame["new"](-10920.125, 624.20275878906, -10266.995117188)
                                L_960_[2] = CFrame["new"](-13277.568359375, 370.34185791016, -7821.1572265625)
                                L_960_[4] = CFrame["new"](-13493.12890625, 318.89553833008, -8373.7919921875)
                                if L_1_[45]["PlayerGui"]["Main"]["Quest"]["Visible"] == true and string["find"](L_1_[45]["PlayerGui"]["Main"]["Quest"]["Container"]["QuestTitle"]["Title"]["Text"], "Defeat 50 Forest Pirates") then
                                        local L_961_ = {}
                                        L_961_[1] = GetConnectionEnemies("Forest Pirate")
                                        if L_961_[1] then
                                                repeat
                                                        wait()
                                                        L_1_[4]["Kill"](L_961_[1], _G["AutoKenVTWO"])
                                                until not _G["AutoKenVTWO"] or L_961_[1]["Humanoid"]["Health"] <= 0 or L_1_[45]["PlayerGui"]["Main"]["Quest"]["Visible"] == false
                                        else
                                                _tp(L_960_[2])
                                        end
                                elseif L_1_[45]["PlayerGui"]["Main"]["Quest"]["Visible"] == true then
                                        local L_962_ = {}
                                        L_962_[1] = GetConnectionEnemies("Captain Elephant")
                                        if L_962_[1] then
                                                repeat
                                                        wait()
                                                        L_1_[4]["Kill"](L_962_[1], _G["AutoKenVTWO"])
                                                until not _G["AutoKenVTWO"] or L_962_[1]["Humanoid"]["Health"] <= 0 or L_1_[45]["PlayerGui"]["Main"]["Quest"]["Visible"] == false
                                        else
                                                _tp(L_960_[4])
                                        end
                                elseif L_1_[45]["PlayerGui"]["Main"]["Quest"]["Visible"] == false then
                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("CitizenQuestProgress", "Citizen")
                                        wait(.1)
                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("StartQuest", "CitizenQuest", 1)
                                end
                                if L_1_[18]["Remotes"]["CommF_"]:InvokeServer("CitizenQuestProgress", "Citizen") == 2 then
                                        _tp(CFrame["new"](-12513.51953125, 340.11373901367, -9873.048828125))
                                end
                                if not L_1_[45]["Backpack"]:FindFirstChild("Fruit Bowl") or not L_1_[45]["Character"]:FindFirstChild("Fruit Bowl") then
                                        if not GetBP("Fruit Bowl") then
                                                if not GetBP("Apple") then
                                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("requestEntrance", Vector3["new"](-12471.169921875, 374.94024658203, -7551.677734375))
                                                        for L_963_forvar0, L_964_forvar1 in pairs(workspace:GetDescendants()) do
                                                                local L_965_ = {}
                                                                L_965_[2], L_965_[3] = L_963_forvar0, L_964_forvar1
                                                                if L_965_[3]["Name"] == "Apple" then
                                                                        L_965_[3]["Handle"]["CFrame"] = L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"] * CFrame["new"](0, 1, 10)
                                                                        wait()
                                                                        firetouchinterest(L_1_[45]["Character"]["HumanoidRootPart"], L_965_[3]["Handle"], 0)
                                                                        wait()
                                                                end
                                                        end
                                                elseif not GetBP("Banana") then
                                                        _tp(CFrame["new"](2286.0078125, 73.133918762207, -7159.8090820312))
                                                        for L_966_forvar0, L_967_forvar1 in pairs(workspace:GetDescendants()) do
                                                                local L_968_ = {}
                                                                L_968_[2], L_968_[3] = L_966_forvar0, L_967_forvar1
                                                                if L_968_[3]["Name"] == "Banana" then
                                                                        L_968_[3]["Handle"]["CFrame"] = L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"] * CFrame["new"](0, 1, 10)
                                                                        wait()
                                                                        firetouchinterest(L_1_[45]["Character"]["HumanoidRootPart"], L_968_[3]["Handle"], 0)
                                                                        wait()
                                                                end
                                                        end
                                                elseif not GetBP("Pineapple") then
                                                        _tp(CFrame["new"](-712.82727050781, 98.577049255371, 5711.9541015625))
                                                        for L_969_forvar0, L_970_forvar1 in pairs(workspace:GetDescendants()) do
                                                                local L_971_ = {}
                                                                L_971_[1], L_971_[2] = L_969_forvar0, L_970_forvar1
                                                                if L_971_[2]["Name"] == "Pineapple" then
                                                                        L_971_[2]["Handle"]["CFrame"] = L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"] * CFrame["new"](0, 1, 10)
                                                                        wait()
                                                                        firetouchinterest(L_1_[45]["Character"]["HumanoidRootPart"], L_971_[2]["Handle"], 0)
                                                                        wait()
                                                                end
                                                        end
                                                end
                                        end
                                        if L_1_[45]["Backpack"]:FindFirstChild("Banana") and (L_1_[45]["Backpack"]:FindFirstChild("Apple") and L_1_[45]["Backpack"]:FindFirstChild("Pineapple")) or L_1_[45]:FindFirstChild("Banana") and (L_1_[45]:FindFirstChild("Apple") and L_1_[45]:FindFirstChild("Pineapple")) then
                                                repeat
                                                        wait()
                                                        _tp(L_960_[1])
                                                until _G["AutoKenVTWO"] or L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"] == L_960_[1]
                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("CitizenQuestProgress", "Citizen")
                                        end
                                        if L_1_[45]["Backpack"]:FindFirstChild("Fruit Bowl") or L_1_[45]["Character"]:FindFirstChild("Fruit Bowl") then
                                                if L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"] ~= L_960_[3] then
                                                        _tp(L_960_[3])
                                                elseif L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"] == L_960_[3] then
                                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("KenTalk2", "Start")
                                                        wait(.1)
                                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("KenTalk2", "Buy")
                                                end
                                        end
                                end
                        end)
                end
        end
end)

spawn(function()
        pcall(function()
                while wait(Sec) do
                        if _G["Auto_Rainbow_Haki"] then
                                if L_1_[45]["PlayerGui"]["Main"]["Quest"]["Visible"] == false then
                                        if _G["GetQFast"] then
                                                if L_1_[45]["PlayerGui"]["Main"]["Quest"]["Visible"] == false then
                                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("HornedMan", "Bet")
                                                end
                                        else
                                                Rainbow1 = CFrame["new"](-11892.0703125, 930.57672119141, -8760.1591796875)
                                                if L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"] ~= Rainbow1 then
                                                        _tp(Rainbow1)
                                                elseif L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"] == Rainbow1 then
                                                        wait(1)
                                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("HornedMan", "Bet")
                                                end
                                        end
                                elseif L_1_[45]["PlayerGui"]["Main"]["Quest"]["Visible"] == true and string["find"](L_1_[45]["PlayerGui"]["Main"]["Quest"]["Container"]["QuestTitle"]["Title"]["Text"], "Stone") then
                                        local L_947_ = {}
                                        L_947_[1] = GetConnectionEnemies("Stone")
                                        if L_947_[1] then
                                                repeat
                                                        wait()
                                                        L_1_[4]["Kill"](L_947_[1], _G["Auto_Rainbow_Haki"])
                                                until _G["Auto_Rainbow_Haki"] == false or L_947_[1]["Humanoid"]["Health"] <= 0 or not L_947_[1]["Parent"] or L_1_[45]["PlayerGui"]["Main"]["Quest"]["Visible"] == false
                                        else
                                                _tp(CFrame["new"](-1086.11621, 38.8425903, 6768.71436, .0231462717, -0.592676699, .805107772, 2.03251839e-05, .805323839, .592835128, -0.999732077, -0.0137055516, .0186523199))
                                        end
                                elseif L_1_[45]["PlayerGui"]["Main"]["Quest"]["Visible"] == true and string["find"](L_1_[45]["PlayerGui"]["Main"]["Quest"]["Container"]["QuestTitle"]["Title"]["Text"], "Hydra Leader") then
                                        local L_948_ = {}
                                        L_948_[2] = GetConnectionEnemies("Hydra Leader")
                                        if L_948_[2] then
                                                repeat
                                                        task["wait"]()
                                                        L_1_[4]["Kill"](L_948_[2], _G["Auto_Rainbow_Haki"])
                                                until _G["Auto_Rainbow_Haki"] == false or L_948_[2]["Humanoid"]["Health"] <= 0 or not L_948_[2]["Parent"] or L_1_[45]["PlayerGui"]["Main"]["Quest"]["Visible"] == false
                                        else
                                                local L_949_ = {}
                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("requestEntrance", Vector3["new"](5643.4526367188, 1013.0858154297, -340.51025390625))
                                                L_949_[2] = Vector3["new"](5643.4526367188, 1013.0858154297, -340.51025390625)
                                                L_949_[1] = CFrame["new"](5821.8979492188, 1019.0950927734, -73.719230651855)
                                                if L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"]["Position"] == L_949_[2] then
                                                        _tp(L_949_[1])
                                                end
                                        end
                                elseif L_1_[45]["PlayerGui"]["Main"]["Quest"]["Visible"] == true and string["find"](L_1_[45]["PlayerGui"]["Main"]["Quest"]["Container"]["QuestTitle"]["Title"]["Text"], "Kilo Admiral") then
                                        local L_950_ = {}
                                        L_950_[2] = GetConnectionEnemies("Kilo Admiral")
                                        if L_950_[2] then
                                                repeat
                                                        task["wait"]()
                                                        L_1_[4]["Kill"](L_950_[2], _G["Auto_Rainbow_Haki"])
                                                until _G["Auto_Rainbow_Haki"] == false or L_950_[2]["Humanoid"]["Health"] <= 0 or not L_950_[2]["Parent"] or L_1_[45]["PlayerGui"]["Main"]["Quest"]["Visible"] == false
                                        else
                                                _tp(CFrame["new"](2877.61743, 423.558685, -7207.31006, -0.989591599, 0, -0.143904909, 0, 1.00000012, 0, .143904924, 0, -0.989591479))
                                        end
                                elseif L_1_[45]["PlayerGui"]["Main"]["Quest"]["Visible"] == true and string["find"](L_1_[45]["PlayerGui"]["Main"]["Quest"]["Container"]["QuestTitle"]["Title"]["Text"], "Captain Elephant") then
                                        local L_951_ = {}
                                        L_951_[2] = GetConnectionEnemies("Captain Elephant")
                                        if L_951_[2] then
                                                repeat
                                                        task["wait"]()
                                                        L_1_[4]["Kill"](L_951_[2], _G["Auto_Rainbow_Haki"])
                                                until _G["Auto_Rainbow_Haki"] == false or L_951_[2]["Humanoid"]["Health"] <= 0 or not L_951_[2]["Parent"] or L_1_[45]["PlayerGui"]["Main"]["Quest"]["Visible"] == false
                                        else
                                                local L_952_ = {}
                                                L_952_[3] = Vector3["new"](-12471.169921875, 374.94024658203, -7551.677734375)
                                                L_952_[1] = CFrame["new"](-13376.7578125, 433.28689575195, -8071.392578125)
                                                if L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"]["Position"] ~= L_952_[3] then
                                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("requestEntrance", Vector3["new"](-12471.169921875, 374.94024658203, -7551.677734375))
                                                elseif L_1_[45]["Character"]["HumanoidRootPart"]["CFrame"]["Position"] == L_952_[3] then
                                                        _tp(L_952_[1])
                                                end
                                        end
                                elseif L_1_[45]["PlayerGui"]["Main"]["Quest"]["Visible"] == true and string["find"](L_1_[45]["PlayerGui"]["Main"]["Quest"]["Container"]["QuestTitle"]["Title"]["Text"], "Beautiful Pirate") then
                                        local L_953_ = {}
                                        L_953_[2] = GetConnectionEnemies("Captain Elephant")
                                        if L_953_[2] then
                                                repeat
                                                        task["wait"]()
                                                        L_1_[4]["Kill"](L_953_[2], _G["Auto_Rainbow_Haki"])
                                                until _G["Auto_Rainbow_Haki"] == false or L_953_[2]["Humanoid"]["Health"] <= 0 or not L_953_[2]["Parent"] or L_1_[45]["PlayerGui"]["Main"]["Quest"]["Visible"] == false
                                        else
                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("requestEntrance", Vector3["new"](5314.5463867188, 22.562219619751, -127.06755065918))
                                        end
                                end
                        end
                end
        end)
end)

spawn(function()
        while wait(Sec) do
                pcall(function()
                        if _G["Bartilo_Quest"] and Lv >= 850 then
                                local L_974_ = {}
                                L_974_[2] = L_1_[45]["PlayerGui"]["Main"]["Quest"]
                                if L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BartiloQuestProgress", "Bartilo") == 0 then
                                        if L_974_[2]["Visible"] == false then
                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("StartQuest", "BartiloQuest", 1)
                                        elseif L_974_[2]["Visible"] == true then
                                                local L_975_ = {}
                                                L_975_[1] = GetConnectionEnemies("Swan Pirate")
                                                if L_975_[1] then
                                                        repeat
                                                                wait()
                                                                L_1_[4]["Kill"](L_975_[1], _G["Bartilo_Quest"])
                                                        until not _G["Bartilo_Quest"] or L_975_[1]["Humanoid"]["Health"] <= 0 or L_974_[2]["Visible"] == false
                                                else
                                                        _tp(CFrame["new"](-428.99899291992, 72.983779907227, 1836.43359375))
                                                end
                                        end
                                elseif L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BartiloQuestProgress", "Bartilo") == 1 then
                                        if L_974_[2]["Visible"] == false then
                                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("StartQuest", "BartiloQuest", 2)
                                        elseif L_974_[2]["Visible"] == true then
                                                local L_976_ = {}
                                                L_976_[1] = GetConnectionEnemies("Factory Staff")
                                                if L_976_[1] then
                                                        repeat
                                                                wait()
                                                                L_1_[4]["Kill"](L_976_[1], _G["Bartilo_Quest"])
                                                        until not _G["Bartilo_Quest"] or L_976_[1]["Humanoid"]["Health"] <= 0 or L_974_[2]["Visible"] == false
                                                else
                                                        _tp(CFrame["new"](447.99932861328, 73.983779907227, 1840.3334960938))
                                                end
                                        end
                                elseif L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 then
                                        local L_977_ = {}
                                        L_977_[1] = GetConnectionEnemies("Jeremy")
                                        if L_977_[1] then
                                                repeat
                                                        wait()
                                                        L_1_[4]["Kill"](L_977_[1], _G["Bartilo_Quest"])
                                                until not _G["Bartilo_Quest"] or L_977_[1]["Humanoid"]["Health"] <= 0
                                        else
                                                _tp(CFrame["new"](-10, 331.12097167969, 2815.4951171875))
                                        end
                                end
                        end
                end)
        end
        end)
end

return ProgressionModule
