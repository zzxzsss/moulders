
-- ESP, fighting styles, sea events, PVP features

-- Access shared state from CoreModule
local L_1_ = getgenv().L_1_ or {}
getgenv().L_1_ = L_1_

local EventsAndPVPModule = {}

-- Data Tables
L_1_[130] = {
    "Guardian",
    "PirateGrandBrigade",
    "MarineGrandBrigade",
    "PirateBrigade",
    "MarineBrigade",
    "PirateSloop",
    "MarineSloop",
    "Beast Hunter"
}

L_1_[89] = {
    "Lv 1",
    "Lv 2",
    "Lv 3",
    "Lv 4",
    "Lv 5",
    "Lv 6",
    "Lv Infinite"
}

-- Utility Functions
GetSeaBeastTrial = function()
    if not workspace["Map"]:FindFirstChild("FishmanTrial") then
        return nil
    end
    if workspace["_WorldOrigin"]["Locations"]:FindFirstChild("Trial of Water") then
        FishmanTrial = workspace["_WorldOrigin"]["Locations"]:FindFirstChild("Trial of Water")
    end
    if FishmanTrial then
        for L_1082_forvar0, L_1083_forvar1 in next, workspace["SeaBeasts"]:GetChildren() do
            local L_1084_ = {}
            L_1084_[3], L_1084_[2] = L_1082_forvar0, L_1083_forvar1
            if L_1084_[2]:FindFirstChild("HumanoidRootPart") and (L_1084_[2]["HumanoidRootPart"]["Position"] - FishmanTrial["Position"])["Magnitude"] <= 1500 then
                if L_1084_[2]["Health"]["Value"] > 0 then
                    return L_1084_[2]
                end
            end
        end
    end
end

function printBeltName(L_1093_arg0)
    local L_1094_ = {}
    L_1094_[1] = L_1093_arg0
    if type(L_1094_[1]) == "table" and L_1094_[1]["Quest"]["BeltName"] then
        return L_1094_[1]["Quest"]["BeltName"]
    end
end

ChestEsp = function()
    if ChestESP then
        local L_1363_ = {}
        L_1363_[1] = game:GetService("CollectionService")
        L_1363_[3] = L_1363_[1]:GetTagged("_ChestTagged")
        for L_1364_forvar0, L_1365_forvar1 in ipairs(L_1363_[3]) do
            local L_1366_ = {}
            L_1366_[2], L_1366_[1] = L_1364_forvar0, L_1365_forvar1
            pcall(function()
                local L_1367_ = {}
                L_1367_[3] = (L_1366_[1]:GetPivot())["Position"]
                L_1367_[5] = (L_1367_[3] - L_1_[23]["Character"]["Head"]["Position"])["Magnitude"]
                L_1367_[2] = (L_1366_[1]:GetFullName()):gsub("[^%w_]", "_")
                L_1367_[4] = L_1366_[1]:FindFirstChild("ChestEspAttachment")
                if not L_1367_[4] then
                    local L_1368_ = {}
                    L_1368_[2] = Instance["new"]("Attachment")
                    L_1368_[2]["Name"] = "ChestEspAttachment"
                    L_1368_[2]["Parent"] = L_1366_[1]
                    L_1368_[2]["Position"] = Vector3["new"](0, 3, 0)
                    L_1368_[3] = Instance["new"]("BillboardGui")
                    L_1368_[3]["Name"] = "NameEsp"
                    L_1368_[3]["Size"] = UDim2["new"](0, 200, 0, 30)
                    L_1368_[3]["Adornee"] = L_1368_[2]
                    L_1368_[3]["ExtentsOffset"] = Vector3["new"](0, 1, 0)
                    L_1368_[3]["AlwaysOnTop"] = true
                    L_1368_[3]["Parent"] = L_1368_[2]
                    L_1368_[1] = Instance["new"]("TextLabel")
                    L_1368_[1]["Font"] = Enum["Font"]["Code"]
                    L_1368_[1]["TextSize"] = 14
                    L_1368_[1]["TextWrapped"] = true
                    L_1368_[1]["Size"] = UDim2["new"](1, 0, 1, 0)
                    L_1368_[1]["TextYAlignment"] = Enum["TextYAlignment"]["Top"]
                    L_1368_[1]["BackgroundTransparency"] = 1
                    L_1368_[1]["TextStrokeTransparency"] = .5
                    L_1368_[1]["TextColor3"] = Color3["fromRGB"](80, 245, 245)
                    L_1368_[1]["Parent"] = L_1368_[3]
                end
                L_1367_[6] = L_1367_[4] and L_1367_[4]:FindFirstChild("NameEsp")
                if L_1367_[6] then
                    local L_1369_ = {}
                    L_1369_[3] = math["floor"](L_1367_[5] / 3)
                    L_1369_[2] = L_1366_[1]["Name"]:gsub("Label", "")
                    L_1367_[6]["TextLabel"]["Text"] = string["format"]("[%s] %d M", L_1369_[2], L_1369_[3])
                end
            end)
        end
    else
        for L_1370_forvar0, L_1371_forvar1 in ipairs((game:GetService("CollectionService")):GetTagged("_ChestTagged")) do
            local L_1372_ = {}
            L_1372_[2], L_1372_[4] = L_1370_forvar0, L_1371_forvar1
            L_1372_[1] = L_1372_[4]:FindFirstChild("ChestEspAttachment")
            if L_1372_[1] then
                L_1372_[1]:Destroy()
            end
        end
    end
end

berriesEsp = function()
    if BerryEsp then
        local L_1373_ = {}
        L_1373_[3] = game:GetService("CollectionService")
        L_1373_[2] = L_1373_[3]:GetTagged("BerryBush")
        for L_1374_forvar0, L_1375_forvar1 in ipairs(L_1373_[2]) do
            local L_1376_ = {}
            L_1376_[1], L_1376_[2] = L_1374_forvar0, L_1375_forvar1
            pcall(function()
                local L_1377_ = {}
                L_1377_[1] = (L_1376_[2]["Parent"]:GetPivot())["Position"]
                for L_1378_forvar0, L_1379_forvar1 in pairs(L_1376_[2]:GetAttributes()) do
                    local L_1380_ = {}
                    L_1380_[3], L_1380_[2] = L_1378_forvar0, L_1379_forvar1
                    if L_1380_[2] then
                        local L_1381_ = {}
                        L_1381_[1] = "BerryEspPart_" .. (L_1380_[2] .. ("_" .. tostring(L_1377_[1])))
                        L_1381_[5] = workspace:FindFirstChild(L_1381_[1])
                        if not L_1381_[5] then
                            L_1381_[5] = Instance["new"]("Part")
                            L_1381_[5]["Name"] = L_1381_[1]
                            L_1381_[5]["Transparency"] = 1
                            L_1381_[5]["Size"] = Vector3["new"](1, 1, 1)
                            L_1381_[5]["Anchored"] = true
                            L_1381_[5]["CanCollide"] = false
                            L_1381_[5]["Parent"] = workspace
                            L_1381_[5]["CFrame"] = CFrame["new"](L_1377_[1])
                        end
                        if not L_1381_[5]:FindFirstChild("NameEsp") then
                            local L_1382_ = {}
                            L_1382_[2] = Instance["new"]("BillboardGui", L_1381_[5])
                            L_1382_[2]["Name"] = "NameEsp"
                            L_1382_[2]["ExtentsOffset"] = Vector3["new"](0, 1, 0)
                            L_1382_[2]["Size"] = UDim2["new"](0, 200, 0, 30)
                            L_1382_[2]["Adornee"] = L_1381_[5]
                            L_1382_[2]["AlwaysOnTop"] = true
                            L_1382_[1] = Instance["new"]("TextLabel", L_1382_[2])
                            L_1382_[1]["Font"] = Enum["Font"]["Code"]
                            L_1382_[1]["TextSize"] = 14
                            L_1382_[1]["TextWrapped"] = true
                            L_1382_[1]["Size"] = UDim2["new"](1, 0, 1, 0)
                            L_1382_[1]["TextYAlignment"] = Enum["TextYAlignment"]["Top"]
                            L_1382_[1]["BackgroundTransparency"] = 1
                            L_1382_[1]["TextStrokeTransparency"] = .5
                            L_1382_[1]["TextColor3"] = Color3["fromRGB"](80, 245, 245)
                        end
                        L_1381_[3] = L_1381_[5]:FindFirstChild("NameEsp")
                        L_1381_[4] = (L_1_[23]["Character"]["Head"]["Position"] - L_1377_[1])["Magnitude"] / 3
                        if L_1381_[3] then
                            L_1381_[3]["TextLabel"]["Text"] = "[" .. (L_1380_[2] .. ("]" .. (" " .. (math["round"](L_1381_[4]) .. " M"))))
                        end
                    end
                end
            end)
        end
    else
        for L_1383_forvar0, L_1384_forvar1 in ipairs(workspace:GetChildren()) do
            local L_1385_ = {}
            L_1385_[3], L_1385_[2] = L_1383_forvar0, L_1384_forvar1
            if L_1385_[2]:IsA("Part") and L_1385_[2]["Name"]:match("BerryEspPart_.*") then
                L_1385_[2]:Destroy()
            end
        end
    end
end

-- Player list for combat
L_1_[39] = {}
for L_1557_forvar0, L_1558_forvar1 in pairs((game:GetService("Players")):GetChildren()) do
    local L_1559_ = {}
    L_1559_[3], L_1559_[1] = L_1557_forvar0, L_1558_forvar1
    table["insert"](L_1_[39], L_1559_[1]["Name"])
end

-- Services
L_1_[30] = game:GetService("Players")
L_1_[10] = game:GetService("UserInputService")
L_1_[119] = game:GetService("RunService")
L_1_[52] = L_1_[30]["LocalPlayer"]
L_1_[69] = false
L_1_[129] = 50
L_1_[115] = {
    ["f"] = 0,
    ["b"] = 0,
    ["l"] = 0,
    ["r"] = 0
}

-- Fly Functions
L_1_[75] = function()
    local L_1598_ = {}
    L_1598_[1] = function()
        local L_1599_ = {}
        L_1599_[2] = L_1_[52]["Character"]
        if not L_1599_[2] then
            return
        end
        L_1599_[4] = L_1599_[2]:FindFirstChildOfClass("Humanoid")
        if not L_1599_[4] then
            return
        end
        L_1599_[1] = L_1599_[4]["MoveDirection"]
        L_1_[115]["f"] = 0
        L_1_[115]["b"] = 0
        L_1_[115]["l"] = 0
        L_1_[115]["r"] = 0
        if L_1599_[1]["Z"] < -0.1 then
            L_1_[115]["f"] = 1
        elseif L_1599_[1]["Z"] > .1 then
            L_1_[115]["b"] = 1
        end
        if L_1599_[1]["X"] < -0.1 then
            L_1_[115]["l"] = 1
        elseif L_1599_[1]["X"] > .1 then
            L_1_[115]["r"] = 1
        end
    end
    L_1598_[3] = L_1_[119]["Heartbeat"]:Connect(function()
        if L_1_[69] then
            L_1598_[1]()
        else
            if L_1598_[3] then
                L_1598_[3]:Disconnect()
            end
        end
    end)
end

L_1_[102] = function(L_1600_arg0)
    local L_1601_ = {}
    L_1601_[2] = L_1600_arg0
    L_1_[69] = L_1601_[2]
    if L_1_[69] then
        local L_1602_ = {}
        if not L_1_[52]["Character"] then
            return
        end
        L_1602_[1] = L_1_[52]["Character"]:FindFirstChildOfClass("Humanoid")
        if L_1_[52]["Character"]:FindFirstChild("Torso") then
            L_1602_[4] = L_1_[52]["Character"]["Torso"]
        else
            L_1602_[4] = L_1_[52]["Character"]["UpperTorso"]
        end
        if not L_1602_[1] or not L_1602_[4] then
            return
        end
        for L_1603_forvar0, L_1604_forvar1 in ipairs(L_1_[52]["Character"]:GetDescendants()) do
            local L_1605_ = {}
            L_1605_[3], L_1605_[2] = L_1603_forvar0, L_1604_forvar1
            if L_1605_[2]:IsA("BasePart") then
                L_1605_[2]["CanCollide"] = false
                L_1605_[2]["Massless"] = true
            end
        end
        L_1602_[2] = L_1_[52]["Character"]["DescendantAdded"]:Connect(function(L_1606_arg0)
            local L_1607_ = {}
            L_1607_[2] = L_1606_arg0
            if L_1_[69] and L_1607_[2]:IsA("BasePart") then
                L_1607_[2]["CanCollide"] = false
                L_1607_[2]["Massless"] = true
            end
        end)
        L_1_[49] = Instance["new"]("BodyGyro", L_1602_[4])
        L_1_[49]["P"] = 90000
        L_1_[49]["maxTorque"] = Vector3["new"](9000000000, 9000000000, 9000000000)
        L_1_[49]["cframe"] = L_1602_[4]["CFrame"]
        L_1_[117] = Instance["new"]("BodyVelocity", L_1602_[4])
        L_1_[117]["velocity"] = Vector3["new"](0, 0, 0)
        L_1_[117]["maxForce"] = Vector3["new"](9000000000, 9000000000, 9000000000)
        L_1602_[1]["PlatformStand"] = true
        L_1_[75]()
        L_1_[47] = L_1_[119]["Heartbeat"]:Connect(function()
            if not L_1_[69] or not L_1_[52]["Character"] then
                return
            end
            for L_1608_forvar0, L_1609_forvar1 in ipairs(L_1_[52]["Character"]:GetDescendants()) do
                local L_1610_ = {}
                L_1610_[1], L_1610_[3] = L_1608_forvar0, L_1609_forvar1
                if L_1610_[3]:IsA("BasePart") and L_1610_[3]["CanCollide"] then
                    L_1610_[3]["CanCollide"] = false
                end
            end
            if L_1_[115]["l"] + L_1_[115]["r"] ~= 0 or L_1_[115]["f"] + L_1_[115]["b"] ~= 0 then
                L_1_[117]["velocity"] = (workspace["CurrentCamera"]["CoordinateFrame"]["lookVector"] * (L_1_[115]["f"] + L_1_[115]["b"]) + (workspace["CurrentCamera"]["CoordinateFrame"] * (CFrame["new"](L_1_[115]["l"] + L_1_[115]["r"], (L_1_[115]["f"] + L_1_[115]["b"]) * .2, 0))["p"] - workspace["CurrentCamera"]["CoordinateFrame"]["p"])) * L_1_[129]
            else
                L_1_[117]["velocity"] = Vector3["new"](0, 0, 0)
            end
            L_1_[49]["cframe"] = workspace["CurrentCamera"]["CoordinateFrame"]
        end)
    else
        if L_1_[47] then
            L_1_[47]:Disconnect()
            L_1_[47] = nil
        end
        if L_1_[52]["Character"] then
            local L_1611_ = {}
            L_1611_[2] = L_1_[52]["Character"]:FindFirstChildOfClass("Humanoid")
            if L_1611_[2] then
                L_1611_[2]["PlatformStand"] = false
            end
            for L_1612_forvar0, L_1613_forvar1 in ipairs(L_1_[52]["Character"]:GetDescendants()) do
                local L_1614_ = {}
                L_1614_[1], L_1614_[3] = L_1612_forvar0, L_1613_forvar1
                if L_1614_[3]:IsA("BasePart") then
                    L_1614_[3]["CanCollide"] = true
                    L_1614_[3]["Massless"] = false
                end
            end
            if L_1_[49] then
                L_1_[49]:Destroy()
            end
            if L_1_[117] then
                L_1_[117]:Destroy()
            end
        end
        L_1_[115] = {
            ["f"] = 0,
            ["b"] = 0,
            ["l"] = 0,
            ["r"] = 0
        }
    end
end

L_1_[91] = function(L_1615_arg0)
    local L_1616_ = {}
    L_1616_[2] = L_1615_arg0
    L_1_[129] = L_1616_[2]
end

L_1_[52]["CharacterAdded"]:Connect(function(L_1617_arg0)
    wait(1)
    if L_1_[69] then
        L_1_[102](false)
        wait(.1)
        L_1_[102](true)
    end
end)

L_1_[48] = function()
    local L_1624_ = {}
    L_1624_[1] = game["Players"]["LocalPlayer"]["Character"]:WaitForChild("Dodge")
    for L_1625_forvar0, L_1626_forvar1 in next, getgc() do
        local L_1627_ = {}
        L_1627_[2], L_1627_[3] = L_1625_forvar0, L_1626_forvar1
        if typeof(L_1627_[3]) == "function" then
            local L_1628_ = {}
            L_1628_[1] = getfenv(L_1627_[3])
            if L_1628_[1]["script"] == L_1624_[1] then
                for L_1629_forvar0, L_1630_forvar1 in next, getupvalues(L_1627_[3]) do
                    local L_1631_ = {}
                    L_1631_[1], L_1631_[3] = L_1629_forvar0, L_1630_forvar1
                    if tostring(L_1631_[3]) == "0.4" then
                        setupvalue(L_1627_[3], L_1631_[1], 0)
                    end
                end
            end
        end
    end
end

L_1_[43] = game["Players"]["LocalPlayer"]
L_1_[20] = function(L_1731_arg0)
    local L_1732_ = {}
    L_1732_[3] = L_1731_arg0
    if not L_1732_[3] then
        return false
    end
    L_1732_[1] = L_1732_[3]:FindFirstChild("Humanoid")
    return L_1732_[1] and L_1732_[1]["Health"] > 0
end

L_1_[134] = function(L_1733_arg0, L_1734_arg1)
    local L_1735_ = {}
    L_1735_[5], L_1735_[3] = L_1733_arg0, L_1734_arg1
    L_1735_[2] = (game:GetService("Workspace"))["Enemies"]:GetChildren()
    L_1735_[7] = (game:GetService("Players")):GetPlayers()
    L_1735_[4] = {}
    L_1735_[1] = (L_1735_[5]:GetPivot())["Position"]
    for L_1736_forvar0, L_1737_forvar1 in ipairs(L_1735_[2]) do
        local L_1738_ = {}
        L_1738_[4], L_1738_[1] = L_1736_forvar0, L_1737_forvar1
        L_1738_[3] = L_1738_[1]:FindFirstChild("HumanoidRootPart")
        if L_1738_[3] and L_1_[20](L_1738_[1]) then
            local L_1739_ = {}
            L_1739_[2] = (L_1738_[3]["Position"] - L_1735_[1])["Magnitude"]
            if L_1739_[2] <= L_1735_[3] then
                table["insert"](L_1735_[4], L_1738_[1])
            end
        end
    end
    for L_1740_forvar0, L_1741_forvar1 in ipairs(L_1735_[7]) do
        local L_1742_ = {}
        L_1742_[2], L_1742_[1] = L_1740_forvar0, L_1741_forvar1
        if L_1742_[1] ~= L_1_[43] and L_1742_[1]["Character"] then
            local L_1743_ = {}
            L_1743_[2] = L_1742_[1]["Character"]:FindFirstChild("HumanoidRootPart")
            if L_1743_[2] and L_1_[20](L_1742_[1]["Character"]) then
                local L_1744_ = {}
                L_1744_[2] = (L_1743_[2]["Position"] - L_1735_[1])["Magnitude"]
                if L_1744_[2] <= L_1735_[3] then
                    table["insert"](L_1735_[4], L_1742_[1]["Character"])
                end
            end
        end
    end
    return L_1735_[4]
end

function AttackNoCoolDown()
    if not _G.FastAttack and not _G.ares then
        return
    end

    local L_1745_ = {}
    L_1745_[7] = (game:GetService("Players"))["LocalPlayer"]
    L_1745_[10] = L_1745_[7]["Character"]
    if not L_1745_[10] then
        return
    end
    L_1745_[1] = nil
    for L_1746_forvar0, L_1747_forvar1 in ipairs(L_1745_[10]:GetChildren()) do
        local L_1748_ = {}
        L_1748_[3], L_1748_[1] = L_1746_forvar0, L_1747_forvar1
        if L_1748_[1]:IsA("Tool") then
            L_1745_[1] = L_1748_[1]
            break
        end
    end
    if not L_1745_[1] then
        return
    end
    L_1745_[14] = L_1_[134](L_1745_[10], 60)
    if #L_1745_[14] == 0 then
        return
    end
    L_1745_[11] = game:GetService("ReplicatedStorage")
    L_1745_[5] = L_1745_[11]:FindFirstChild("Modules")
    if not L_1745_[5] then
        return
    end
    L_1745_[4] = ((L_1745_[11]:WaitForChild("Modules")):WaitForChild("Net")):WaitForChild("RE/RegisterAttack")
    L_1745_[2] = ((L_1745_[11]:WaitForChild("Modules")):WaitForChild("Net")):WaitForChild("RE/RegisterHit")
    if not L_1745_[4] or not L_1745_[2] then
        return
    end
    L_1745_[6], L_1745_[12] = {}, nil
    for L_1749_forvar0, L_1750_forvar1 in ipairs(L_1745_[14]) do
        local L_1751_ = {}
        L_1751_[1], L_1751_[3] = L_1749_forvar0, L_1750_forvar1
        if not L_1751_[3]:GetAttribute("IsBoat") then
            local L_1752_ = {}
            L_1752_[1] = {
                "RightLowerArm",
                "RightUpperArm",
                "LeftLowerArm",
                "LeftUpperArm",
                "RightHand",
                "LeftHand"
            }
            L_1752_[2] = L_1751_[3]:FindFirstChild(L_1752_[1][math["random"](#L_1752_[1])]) or L_1751_[3]["PrimaryPart"]
            if L_1752_[2] then
                table["insert"](L_1745_[6], {
                    L_1751_[3],
                    L_1752_[2]
                })
                L_1745_[12] = L_1752_[2]
            end
        end
    end
    if not L_1745_[12] then
        return
    end
    L_1745_[4]:FireServer(0)
    L_1745_[13] = L_1745_[7]:FindFirstChild("PlayerScripts")
    if not L_1745_[13] then
        return
    end
    L_1745_[8] = L_1745_[13]:FindFirstChildOfClass("LocalScript")
    while not L_1745_[8] do
        L_1745_[13]["ChildAdded"]:Wait()
        L_1745_[8] = L_1745_[13]:FindFirstChildOfClass("LocalScript")
    end
    if getsenv then
        local L_1753_ = {}
        L_1753_[1], L_1753_[3] = pcall(getsenv, L_1745_[8])
        if L_1753_[1] and L_1753_[3] then
            L_1745_[9] = L_1753_[3]["_G"]["SendHitsToServer"]
        end
    end
    L_1745_[15], L_1745_[16] = pcall(function()
        return (require(L_1745_[5]["Flags"]))["COMBAT_REMOTE_THREAD"] or false
    end)
    if L_1745_[15] and (L_1745_[16] and L_1745_[9]) then
        L_1745_[9](L_1745_[12], L_1745_[6])
    elseif L_1745_[15] and not L_1745_[16] then
        L_1745_[2]:FireServer(L_1745_[12], L_1745_[6])
    end
end

spawn(function()
    while task.wait() do
        if _G.FastAttack or _G.ares then
            pcall(AttackNoCoolDown)
        end
    end
end)

CameraShakerR = require(game["ReplicatedStorage"]["Util"]["CameraShaker"])
CameraShakerR:Stop()

get_Monster = function()
    for L_1754_forvar0, L_1755_forvar1 in pairs(workspace["Enemies"]:GetChildren()) do
        local L_1756_ = {}
        L_1756_[1], L_1756_[4] = L_1754_forvar0, L_1755_forvar1
        L_1756_[3] = L_1756_[4]:FindFirstChild("UpperTorso") or L_1756_[4]:FindFirstChild("Head")
        if L_1756_[4]:FindFirstChild("HumanoidRootPart", true) and L_1756_[3] then
            if (L_1756_[4]["Head"]["Position"] - L_1_[42]["Character"]["HumanoidRootPart"]["Position"])["Magnitude"] <= 50 then
                return true, L_1756_[3]["Position"]
            end
        end
    end
    for L_1757_forvar0, L_1758_forvar1 in pairs(workspace["SeaBeasts"]:GetChildren()) do
        local L_1759_ = {}
        L_1759_[2], L_1759_[3] = L_1757_forvar0, L_1758_forvar1
        if L_1759_[3]:FindFirstChild("HumanoidRootPart") and (L_1759_[3]:FindFirstChild("Health") and L_1759_[3]["Health"]["Value"] > 0) then
            return true, L_1759_[3]["HumanoidRootPart"]["Position"]
        end
    end
    for L_1760_forvar0, L_1761_forvar1 in pairs(workspace["Enemies"]:GetChildren()) do
        local L_1762_ = {}
        L_1762_[1], L_1762_[2] = L_1760_forvar0, L_1761_forvar1
        if L_1762_[2]:FindFirstChild("Health") and (L_1762_[2]["Health"]["Value"] > 0 and L_1762_[2]:FindFirstChild("VehicleSeat")) then
            return true, L_1762_[2]["Engine"]["Position"]
        end
    end
end

Actived = function()
    local L_1763_ = {}
    L_1763_[1] = game["Players"]["LocalPlayer"]["Character"]:FindFirstChildOfClass("Tool")
    for L_1764_forvar0, L_1765_forvar1 in next, getconnections(L_1763_[1]["Activated"]) do
        local L_1766_ = {}
        L_1766_[2], L_1766_[3] = L_1764_forvar0, L_1765_forvar1
        if typeof(L_1766_[3]["Function"]) == "function" then
            getupvalues(L_1766_[3]["Function"])
        end
    end
end

-- ============================================
-- SPAWN LOOPS - These check _G variables
-- ============================================

function EventsAndPVPModule.startLoops()

-- Auto SuperHuman
spawn(function()
    while wait(Sec) do
        pcall(function()
            if _G["Auto_SuperHuman"] then
                local L_988_ = {}
                L_988_[2] = L_1_[45]["Data"]["Beli"]["Value"]
                L_988_[1] = L_1_[45]["Data"]["Fragments"]["Value"]
                if L_1_[45]:FindFirstChild("WeaponAssetCache") then
                    if not GetBP("Superhuman") then
                        if not GetBP("Black Leg") then
                            if L_988_[2] >= 150000 then
                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuyBlackLeg")
                            end
                        elseif GetBP("Black Leg") and (GetBP("Black Leg"))["Level"]["Value"] < 299 then
                            _G["Level"] = true
                        elseif GetBP("Black Leg") and (GetBP("Black Leg"))["Level"]["Value"] >= 300 then
                            _G["Level"] = false
                        end
                        if not GetBP("Electro") then
                            if L_988_[2] >= 500000 then
                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuyElectro")
                            end
                        elseif GetBP("Electro") and (GetBP("Electro"))["Level"]["Value"] < 299 then
                            _G["Level"] = true
                        elseif GetBP("Electro") and (GetBP("Electro"))["Level"]["Value"] >= 300 then
                            _G["Level"] = false
                        end
                        if not GetBP("Fishman Karate") then
                            if L_988_[2] >= 750000 then
                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuyFishmanKarate")
                            end
                        elseif GetBP("Fishman Karate") and (GetBP("Fishman Karate"))["Level"]["Value"] < 299 then
                            _G["Level"] = true
                        elseif GetBP("Fishman Karate") and (GetBP("Fishman Karate"))["Level"]["Value"] >= 300 then
                            _G["Level"] = false
                        end
                        if not GetBP("Dragon Claw") then
                            if L_988_[1] >= 1500 then
                                L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BlackbeardReward", "DragonClaw", "2")
                            end
                        elseif GetBP("Dragon Claw") and (GetBP("Dragon Claw"))["Level"]["Value"] < 299 then
                            _G["Level"] = true
                        elseif GetBP("Dragon Claw") and (GetBP("Dragon Claw"))["Level"]["Value"] >= 300 then
                            _G["Level"] = false
                        end
                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuySuperhuman")
                    end
                end
            end
        end)
    end
end)

-- Auto DeathStep
spawn(function()
    while wait(Sec) do
        if _G["AutoDeathStep"] then
            pcall(function()
                if L_1_[45]:FindFirstChild("WeaponAssetCache") then
                    if not GetBP("Death Step") then
                        if not GetBP("Black Leg") then
                            L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuyBlackLeg")
                        end
                        if GetBP("Black Leg") and (GetBP("Black Leg"))["Level"]["Value"] >= 400 then
                            L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuyDeathStep")
                            _G["Level"] = false
                        elseif GetBP("Black Leg") and (GetBP("Black Leg"))["Level"]["Value"] < 399 then
                            _G["Level"] = true
                        end
                        if GetBP("Black Leg") or (GetBP("Black Leg"))["Level"]["Value"] >= 400 then
                            if workspace["Map"]["IceCastle"]["Hall"]["LibraryDoor"]["PhoeyuDoor"]["Transparency"] == 0 then
                                if GetBP("Library Key") then
                                    repeat
                                        wait()
                                        _tp(CFrame["new"](6371.2001953125, 296.63433837891, -6841.1811523438))
                                    until not _G["AutoDeathStep"] or Root["Position"] == (CFrame["new"](6371.2001953125, 296.63433837891, -6841.1811523438))["Position"]
                                    if Root["CFrame"] == CFrame["new"](6371.2001953125, 296.63433837891, -6841.1811523438) then
                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuyDeathStep")
                                    end
                                elseif not GetBP("Library Key") then
                                    local L_991_ = {}
                                    L_991_[1] = GetConnectionEnemies("Awakened Ice Admiral")
                                    if L_991_[1] then
                                        repeat
                                            wait()
                                            L_1_[4]["Kill"](L_991_[1], _G["AutoDeathStep"])
                                        until not L_991_[1]["Parent"] or L_991_[1]["Humanoid"]["Health"] <= 0 or _G["AutoDeathStep"] == false or GetBP("Library Key") or GetBP("Death Step")
                                    else
                                        _tp(CFrame["new"](5668.9780273438, 28.519989013672, -6483.3520507813))
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Auto Sharkman Karate
spawn(function()
    while wait(Sec) do
        if _G["Auto_SharkMan_Karate"] then
            pcall(function()
                if L_1_[45]:FindFirstChild("WeaponAssetCache") then
                    if not GetBP("Sharkman Karate") then
                        if not GetBP("Fishman Karate") then
                            L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuyFishmanKarate")
                        end
                        if GetBP("Fishman Karate") and (GetBP("Fishman Karate"))["Level"]["Value"] >= 400 then
                            L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuySharkmanKarate")
                            _G["Level"] = false
                        elseif GetBP("Fishman Karate") and (GetBP("Fishman Karate"))["Level"]["Value"] < 399 then
                            _G["Level"] = true
                        end
                        if GetBP("Fishman Karate") or (GetBP("Fishman Karate"))["Level"]["Value"] >= 400 then
                            if GetBP("Water Key") then
                                if string["find"](L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuySharkmanKarate"), "keys") then
                                    if GetBP("Water Key") then
                                        repeat
                                            wait()
                                            _tp(CFrame["new"](-2604.6958, 239.432526, -10315.1982, .0425701365, 0, -0.999093413, 0, 1, 0, .999093413, 0, .0425701365))
                                        until not _G["Auto_SharkMan_Karate"] or Root["Position"] == (CFrame["new"](-2604.6958, 239.432526, -10315.1982, .0425701365, 0, -0.999093413, 0, 1, 0, .999093413, 0, .0425701365))["Position"]
                                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuySharkmanKarate")
                                    end
                                end
                            elseif not GetBP("Water Key") then
                                local L_994_ = {}
                                L_994_[2] = GetConnectionEnemies("Tide Keeper")
                                if L_994_[2] then
                                    repeat
                                        wait()
                                        L_1_[4]["Kill"](L_994_[2], _G["Auto_SharkMan_Karate"])
                                    until not L_994_[2]["Parent"] or L_994_[2]["Humanoid"]["Health"] <= 0 or _G["Auto_SharkMan_Karate"] == false or GetBP("Water Key") or GetBP("Sharkman Karate")
                                else
                                    _tp(CFrame["new"](-3053.9814453125, 237.18954467773, -10145.0390625))
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Auto ElectricClaw
spawn(function()
    while wait(Sec) do
        if _G["Auto_Electric_Claw"] then
            pcall(function()
                if L_1_[45]:FindFirstChild("WeaponAssetCache") then
                    if not GetBP("Electro") then
                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuyElectro")
                    end
                    if GetBP("Electro") and (GetBP("Electro"))["Level"]["Value"] >= 400 then
                        if L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuyElectricClaw", "Start") == nil then
                            notween(CFrame["new"](-12548, 337, -7481))
                        end
                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuyElectricClaw")
                    elseif GetBP("Electro") and (GetBP("Electro"))["Level"]["Value"] < 400 then
                        repeat
                            _G["AutoFarm_Bone"] = true
                            wait()
                        until not _G["Auto_Electric_Claw"] or GetBP("Electric Claw")
                        _G["AutoFarm_Bone"] = false
                    end
                end
            end)
        end
    end
end)

-- Auto DragonTalon
spawn(function()
    while wait(Sec) do
        if _G["AutoDragonTalon"] then
            pcall(function()
                if L_1_[45]:FindFirstChild("WeaponAssetCache") then
                    if not GetBP("Dragon Claw") then
                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BlackbeardReward", "DragonClaw", "2")
                    end
                    if GetBP("Dragon Claw") and (GetBP("Dragon Claw"))["Level"]["Value"] >= 400 then
                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("Bones", "Buy", 1, 1)
                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuyDragonTalon")
                    elseif GetBP("Dragon Claw") and (GetBP("Dragon Claw"))["Level"]["Value"] < 400 then
                        repeat
                            _G["AutoFarm_Bone"] = true
                            wait()
                        until not _G["AutoDragonTalon"] or GetBP("Dragon Talon")
                        _G["AutoFarm_Bone"] = false
                    end
                end
            end)
        end
    end
end)

-- Auto Godhuman
spawn(function()
    while wait() do
        pcall(function()
            if _G["Auto_God_Human"] then
                if L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuyGodhuman", true) == L_1_[2]({
                    "Bring me 20 Fish Tai",
                    "ls, 20 Magma Ore, 10",
                    " Dragon Scales and 1",
                    "0 Mystic Droplets."
                }) then
                    if GetM("Dragon Scale") == false or GetM("Dragon Scale") < 10 then
                        if World3 then
                            Lv = 1575
                            _G["Level"] = true
                        else
                            L_1_[18]["Remotes"]["CommF_"]:InvokeServer("TravelZou")
                        end
                    elseif GetM("Fish Tail") == false or GetM("Fish Tail") < 20 then
                        if World3 then
                            Lv = 1775
                            _G["Level"] = true
                        else
                            L_1_[18]["Remotes"]["CommF_"]:InvokeServer("TravelZou")
                        end
                    elseif GetM("Mystic Droplet") == false or GetM("Mystic Droplet") < 10 then
                        if World2 then
                            Lv = 1425
                            _G["Level"] = true
                        else
                            L_1_[18]["Remotes"]["CommF_"]:InvokeServer("TravelDressrosa")
                        end
                    elseif GetM("Magma Ore") == false or GetM("Magma Ore") < 20 then
                        if World2 then
                            Lv = 1175
                            _G["Level"] = true
                        else
                            L_1_[18]["Remotes"]["CommF_"]:InvokeServer("TravelDressrosa")
                        end
                    end
                elseif L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuyGodhuman", true) == 3 then
                    return nil
                else
                    L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuyGodhuman")
                end
            end
        end)
    end
end)

-- Auto SanguineArt
spawn(function()
    while wait(Sec) do
        if _G["Snaguine"] then
            pcall(function()
                if not GetBP("Sanguine Art") then
                    L_1_[18]["Remotes"]["CommF_"]:InvokeServer("Sanguine Art")
                end
                if not GetBP("Sanguine Art") then
                    if GetM("Leviathan Heart") >= 1 then
                        print("Completed!!")
                    else
                        if World3 then
                            _G["DangerSc"] = "Lv Infinite"
                            _G["SailBoats"] = true
                        else
                            _G["SailBoats"] = false
                        end
                    end
                    if GetM("Vampire Fang") <= 19 then
                        if World2 then
                            local L_1003_ = {}
                            L_1003_[1] = GetConnectionEnemies("Vampire")
                            if L_1003_[1] then
                                repeat
                                    task["wait"]()
                                    L_1_[4]["Kill"](L_1003_[1], _G["Snaguine"])
                                until not _G["Snaguine"] or L_1003_[1]["Humanoid"]["Health"] <= 0 or not L_1003_[1]["Parent"]
                            else
                                _tp(CFrame["new"](-6041.2924804688, 6.4027109146118, -1304.6333007812))
                            end
                        else
                            L_1_[18]["Remotes"]["CommF_"]:InvokeServer("TravelDressrosa")
                        end
                    end
                    if GetM("Vampire Fang") >= 20 and GetM("Demonic Wisp") <= 19 then
                        if World3 then
                            local L_1004_ = {}
                            L_1004_[1] = GetConnectionEnemies("Demonic Soul")
                            if L_1004_[1] then
                                repeat
                                    task["wait"]()
                                    L_1_[4]["Kill"](L_1004_[1], _G["Snaguine"])
                                until not _G["Snaguine"] or L_1004_[1]["Humanoid"]["Health"] <= 0 or not L_1004_[1]["Parent"]
                            else
                                _tp(CFrame["new"](-9495.6806640625, 453.58624267578, 5977.3486328125))
                            end
                        else
                            L_1_[18]["Remotes"]["CommF_"]:InvokeServer("TravelZou")
                        end
                    end
                    if GetM("Vampire Fang") >= 20 and (GetM("Demonic Wisp") >= 20 and GetM("Dark Fragment") <= 1) then
                        if World2 then
                            local L_1005_ = {}
                            L_1005_[2] = GetConnectionEnemies("Darkbeard")
                            if L_1005_[2] then
                                repeat
                                    task["wait"]()
                                    L_1_[4]["Kill"](black, _G["Snaguine"])
                                until _G["Snaguine"] or black["Humanoid"]["Health"] <= 0 or not black["Parent"]
                            else
                                _tp(CFrame["new"](3798.4575195313, 13.826690673828, -3399.806640625))
                            end
                        else
                            L_1_[18]["Remotes"]["CommF_"]:InvokeServer("TravelDressrosa")
                        end
                    end
                else
                    L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuySanguineArt")
                end
            end)
        end
    end
end)

-- Auto Find Mirage Island
spawn(function()
    while wait() do
        if _G["FindMirage"] then
            pcall(function()
                if not workspace["_WorldOrigin"]["Locations"]:FindFirstChild("Mirage Island", true) then
                    local L_1008_ = {}
                    L_1008_[1] = CheckBoat()
                    if not L_1008_[1] then
                        local L_1009_ = {}
                        L_1009_[1] = CFrame["new"](-16927.451, 9.086, 433.864)
                        TeleportToTarget(L_1009_[1])
                        if (L_1009_[1]["Position"] - L_1_[45]["Character"]["HumanoidRootPart"]["Position"])["Magnitude"] <= 10 then
                            L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuyBoat", _G["SelectedBoat"])
                        end
                    else
                        if L_1_[45]["Character"]["Humanoid"]["Sit"] == false then
                            local L_1010_ = {}
                            L_1010_[2] = L_1008_[1]["VehicleSeat"]["CFrame"] * CFrame["new"](0, 1, 0)
                            _tp(L_1010_[2])
                        else
                            repeat
                                local L_1011_ = {}
                                wait()
                                L_1011_[1] = CFrame["new"](-10000000, 31, 37016.25)
                                if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then
                                    _tp(CFrame["new"](-10000000, 150, 37016.25))
                                else
                                    _tp(CFrame["new"](-10000000, 31, 37016.25))
                                end
                            until not _G["FindMirage"] or (L_1011_[1]["Position"] - L_1_[45]["Character"]["HumanoidRootPart"]["Position"])["Magnitude"] <= 10 or workspace["_WorldOrigin"]["Locations"]:FindFirstChild("Mirage Island") or L_1_[45]["Character"]["Humanoid"]["Sit"] == false
                            L_1_[45]["Character"]["Humanoid"]["Sit"] = false
                        end
                    end
                else
                    _tp(workspace["Map"]["MysticIsland"]["Center"]["CFrame"] * CFrame["new"](0, 300, 0))
                end
            end)
        end
    end
end)

-- Auto Tween To Mirage Island
spawn(function()
    while task["wait"](.1) do
        pcall(function()
            if _G["AutoMysticIsland"] then
                for L_1016_forvar0, L_1017_forvar1 in pairs((game:GetService("Workspace"))["_WorldOrigin"]["Locations"]:GetChildren()) do
                    if L_1017_forvar1["Name"] == "Mirage Island" then
                        tween(L_1017_forvar1["CFrame"] * CFrame["new"](0, 300, 0))
                    end
                end
            end
        end)
    end
end)

-- Auto Upgrade FishMan
spawn(function()
    while wait(Sec) do
        pcall(function()
            if _G["Auto_Fish"] then
                if L_1_[18]["Remotes"]["CommF_"]:InvokeServer("Alchemist", "1") ~= -2 then
                    if L_1_[18]["Remotes"]["CommF_"]:InvokeServer("Alchemist", "1") == 0 then
                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("Alchemist", "2")
                    elseif L_1_[18]["Remotes"]["CommF_"]:InvokeServer("Alchemist", "1") == 1 then
                        if not L_1_[45]["Backpack"]:FindFirstChild("Flower 1") and not L_1_[45]["Character"]:FindFirstChild("Flower 1") then
                            _tp(workspace["Flower1"]["CFrame"])
                        elseif not L_1_[45]["Backpack"]:FindFirstChild("Flower 2") and not L_1_[45]["Character"]:FindFirstChild("Flower 2") then
                            _tp(workspace["Flower2"]["CFrame"])
                        elseif not L_1_[45]["Backpack"]:FindFirstChild("Flower 3") and not L_1_[45]["Character"]:FindFirstChild("Flower 3") then
                            local L_1061_ = {}
                            L_1061_[1] = GetConnectionEnemies("Swan Pirate")
                            if L_1061_[1] then
                                repeat
                                    wait()
                                    L_1_[4]["Kill"](L_1061_[1], _G["Auto_Fish"])
                                until L_1_[45]["Backpack"]:FindFirstChild("Flower 3") or not L_1061_[1]["Parent"] or L_1061_[1]["Humanoid"]["Health"] <= 0 or _G["Auto_Fish"] == false
                            else
                                _tp(CFrame["new"](980.09851074219, 121.33129882812, 1287.2093505859))
                            end
                        end
                    elseif L_1_[18]["Remotes"]["CommF_"]:InvokeServer("Alchemist", "1") == 2 then
                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("Alchemist", "3")
                    end
                elseif L_1_[18]["Remotes"]["CommF_"]:InvokeServer("Wenlocktoad", "1") == 0 then
                    L_1_[18]["Remotes"]["CommF_"]:InvokeServer("Wenlocktoad", "2")
                elseif L_1_[18]["Remotes"]["CommF_"]:InvokeServer("Wenlocktoad", "1") == 1 then
                    warn("Sea Beast Soon")
                end
            end
        end)
    end
end)

-- Auto Pull Lever
spawn(function()
    while wait(Sec) do
        if _G["Lver"] then
            pcall(function()
                for L_1064_forvar0, L_1065_forvar1 in pairs(workspace["Map"]["Temple of Time"]:GetDescendants()) do
                    local L_1066_ = {}
                    L_1066_[3], L_1066_[2] = L_1064_forvar0, L_1065_forvar1
                    if L_1066_[2]["Name"] == "ProximityPrompt" then
                        fireproximityprompt(L_1066_[2], math["huge"])
                    end
                end
            end)
        end
    end
end)

-- Auto Train V4
spawn(function()
    while wait(Sec) do
        pcall(function()
            if _G["AcientOne"] then
                local L_1069_ = {}
                L_1069_[2] = {
                    "Reborn Skeleton",
                    "Living Zombie",
                    "Demonic Soul",
                    "Posessed Mummy"
                }
                for L_1070_forvar0 = 1, #L_1069_[2], 1 do
                    if (L_1_[45]["Character"]:FindFirstChild("RaceEnergy"))["Value"] == 1 then
                        vim1:SendKeyEvent(true, "Y", false, game)
                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("UpgradeRace", "Buy")
                        _tp(CFrame["new"](-8987.041015625, 215.86206054688, 5886.7104492188))
                    elseif (L_1_[45]["Character"]:FindFirstChild("RaceTransformed"))["Value"] == false then
                        local L_1071_ = {}
                        L_1071_[1] = GetConnectionEnemies(L_1069_[2])
                        if L_1071_[1] then
                            repeat
                                wait()
                                L_1_[4]["Kill"](L_1071_[1], _G["AcientOne"])
                            until _G["AcientOne"] == false or L_1071_[1]["Humanoid"]["Health"] <= 0 or not L_1071_[1]["Parent"]
                        else
                            _tp(CFrame["new"](-9495.6806640625, 453.58624267578, 5977.3486328125))
                        end
                    end
                end
            end
        end)
    end
end)

-- Auto Teleport to Race Doors
spawn(function()
    while wait(Sec) do
        pcall(function()
            if _G["TPDoor"] then
                if tostring(L_1_[45]["Data"]["Race"]["Value"]) == "Mink" then
                    _tp(CFrame["new"](29020.66015625, 14889.426757812, -379.2682800293))
                elseif tostring(L_1_[45]["Data"]["Race"]["Value"]) == "Fishman" then
                    _tp(CFrame["new"](28224.056640625, 14889.426757812, -210.58720397949))
                elseif tostring(L_1_[45]["Data"]["Race"]["Value"]) == "Cyborg" then
                    _tp(CFrame["new"](28492.4140625, 14894.426757812, -422.11001586914))
                elseif tostring(L_1_[45]["Data"]["Race"]["Value"]) == "Skypiea" then
                    _tp(CFrame["new"](28967.408203125, 14918.075195312, 234.31198120117))
                elseif tostring(L_1_[45]["Data"]["Race"]["Value"]) == "Ghoul" then
                    _tp(CFrame["new"](28672.720703125, 14889.127929688, 454.59616088867))
                elseif tostring(L_1_[45]["Data"]["Race"]["Value"]) == "Human" then
                    _tp(CFrame["new"](29237.294921875, 14889.426757812, -206.94955444336))
                end
            end
        end)
    end
end)

-- Auto Complete Trial Race - Mink
spawn(function()
    while wait(Sec) do
        pcall(function()
            if _G["Complete_Trials"] then
                if tostring(L_1_[45]["Data"]["Race"]["Value"]) == "Mink" then
                    notween(workspace["Map"]["MinkTrial"]["Ceiling"]["CFrame"] * CFrame["new"](0, -20, 0))
                end
            end
        end)
    end
end)

-- Auto Complete Trial Race - Fishman
spawn(function()
    while wait(Sec) do
        pcall(function()
            if _G["Complete_Trials"] then
                if tostring(L_1_[45]["Data"]["Race"]["Value"]) == "Fishman" then
                    if GetSeaBeastTrial() then
                        repeat
                            task["wait"]()
                            spawn(function()
                                _tp(CFrame["new"]((GetSeaBeastTrial())["HumanoidRootPart"]["Position"]["X"], (game:GetService("Workspace"))["Map"]["WaterBase-Plane"]["Position"]["Y"] + 300, (GetSeaBeastTrial())["HumanoidRootPart"]["Position"]["Z"]))
                            end)
                            MousePos = (GetSeaBeastTrial())["HumanoidRootPart"]["Position"]
                            Useskills("Melee", "Z")
                            Useskills("Melee", "X")
                            Useskills("Melee", "C")
                            wait(.1)
                            Useskills("Sword", "Z")
                            Useskills("Sword", "X")
                            wait(.1)
                            Useskills("Blox Fruit", "Z")
                            Useskills("Blox Fruit", "X")
                            Useskills("Blox Fruit", "C")
                            wait(.1)
                            Useskills("Gun", "Z")
                            Useskills("Gun", "X")
                        until _G["Complete_Trials"] == false or not GetSeaBeastTrial()
                    end
                end
            end
        end)
    end
end)

-- Auto Complete Trial Race - Cyborg
spawn(function()
    while wait(Sec) do
        pcall(function()
            if _G["Complete_Trials"] then
                if tostring(L_1_[45]["Data"]["Race"]["Value"]) == "Cyborg" then
                    _tp(workspace["Map"]["CyborgTrial"]["Floor"]["CFrame"] * CFrame["new"](0, 500, 0))
                end
            end
        end)
    end
end)

-- Auto Complete Trial Race - Skypiea
spawn(function()
    while wait(Sec) do
        pcall(function()
            if _G["Complete_Trials"] then
                if tostring(L_1_[45]["Data"]["Race"]["Value"]) == "Skypiea" then
                    notween(workspace["Map"]["SkyTrial"]["Model"]["FinishPart"]["CFrame"])
                end
            end
        end)
    end
end)

-- Auto Complete Trial Race - Human/Ghoul
spawn(function()
    while wait(.1) do
        pcall(function()
            if _G["Complete_Trials"] then
                if tostring(L_1_[45]["Data"]["Race"]["Value"]) == "Human" or tostring(L_1_[45]["Data"]["Race"]["Value"]) == "Ghoul" then
                    local L_1085_ = {}
                    L_1085_[2] = {
                        "Ancient Vampire",
                        "Ancient Zombie"
                    }
                    L_1085_[3] = GetConnectionEnemies(L_1085_[2])
                    if L_1085_[3] then
                        repeat
                            wait()
                            L_1_[4]["Kill"](L_1085_[3], _G["Complete_Trials"])
                        until _G["Complete_Trials"] == false or not L_1085_[3]["Parent"] or L_1085_[3]["Humanoid"]["Health"] <= 0
                    end
                end
            end
        end)
    end
end)

-- Auto Kill Player After Trial
spawn(function()
    while task["wait"](Sec) do
        pcall(function()
            if _G["Defeating"] then
                for L_1088_forvar0, L_1089_forvar1 in pairs(workspace["Characters"]:GetChildren()) do
                    local L_1090_ = {}
                    L_1090_[2], L_1090_[1] = L_1088_forvar0, L_1089_forvar1
                    if L_1090_[1]["Name"] ~= L_1_[45]["Name"] then
                        if L_1090_[1]["Humanoid"]["Health"] > 0 and (L_1090_[1]:FindFirstChild("HumanoidRootPart") and (L_1090_[1]["Parent"] and (Root["Position"] - L_1090_[1]["HumanoidRootPart"]["Position"])["Magnitude"] <= 250)) then
                            repeat
                                task["wait"]()
                                EquipWeapon(_G["SelectWeapon"])
                                _tp(L_1090_[1]["HumanoidRootPart"]["CFrame"] * CFrame["new"](0, 0, 15))
                                sethiddenproperty(L_1_[45], "SimulationRadius", math["huge"])
                            until _G["Defeating"] == false or L_1090_[1]["Humanoid"]["Health"] <= 0 or not L_1090_[1]["Parent"] or not L_1090_[1]:FindFirstChild("HumanoidRootPart") or not L_1090_[1]:FindFirstChild("Humanoid")
                        end
                    end
                end
            end
        end)
    end
end)

-- Ship Speed Modifier
(game:GetService("RunService"))["RenderStepped"]:Connect(function()
    if (getgenv())["SpeedBoat"] then
        local L_1209_ = {}
        L_1209_[1] = (game:GetService("Players"))["LocalPlayer"]
        if L_1209_[1]["Character"] and L_1209_[1]["Character"]:FindFirstChild("Humanoid") then
            if L_1209_[1]["Character"]["Humanoid"]["Sit"] then
                for L_1210_forvar0, L_1211_forvar1 in pairs((game:GetService("Workspace"))["Boats"]:GetChildren()) do
                    local L_1212_ = {}
                    L_1212_[3], L_1212_[4] = L_1210_forvar0, L_1211_forvar1
                    L_1212_[1] = L_1212_[4]:FindFirstChildWhichIsA("VehicleSeat")
                    if L_1212_[1] then
                        L_1212_[1]["MaxSpeed"] = SetSpeedBoat
                    end
                end
            end
        end
    end
end)

-- Auto Press W
spawn(function()
    while wait() do
        pcall(function()
            if (getgenv())["AutoPressW"] then
                local L_1217_ = {}
                L_1217_[1] = game["Players"]["LocalPlayer"]["Character"]:WaitForChild("Humanoid")
                if L_1217_[1]["Sit"] == true then
                    (game:GetService("VirtualInputManager")):SendKeyEvent(true, "W", false, game)
                end
            end
        end)
    end
end)

-- No Clip Ship
spawn(function()
    while wait() do
        pcall(function()
            for L_1220_forvar0, L_1221_forvar1 in pairs((game:GetService("Workspace"))["Boats"]:GetChildren()) do
                local L_1222_ = {}
                L_1222_[1], L_1222_[2] = L_1220_forvar0, L_1221_forvar1
                for L_1223_forvar0, L_1224_forvar1 in pairs(L_1222_[2]:GetDescendants()) do
                    local L_1225_ = {}
                    L_1225_[1], L_1225_[3] = L_1223_forvar0, L_1224_forvar1
                    if L_1225_[3]:IsA("BasePart") then
                        if (getgenv())["NoClipShip"] or (getgenv())["FindPrehistoric"] then
                            L_1225_[3]["CanCollide"] = false
                        else
                            L_1225_[3]["CanCollide"] = true
                        end
                    end
                end
            end
        end)
    end
end)

-- Auto Sail Boat
spawn(function()
    while wait() do
        if _G["SailBoats"] then
            pcall(function()
                local L_1240_ = {}
                L_1240_[2] = CheckBoat()
                if not L_1240_[2] and (not(CheckShark() and _G["Shark"] or CheckTerrorShark() and _G["TerrorShark"] or CheckFishCrew() and _G["MobCrew"] or CheckPiranha() and _G["Piranha"]) and (not(CheckEnemiesBoat() and _G["FishBoat"]) and (not(CheckSeaBeast() and _G["SeaBeast1"]) and (not(_G["PGB"] and CheckPirateGrandBrigade()) and (not(_G["HCM"] and CheckHauntedCrew()) and not(_G["Leviathan1"] and CheckLeviathan())))))) then
                    local L_1241_ = {}
                    L_1241_[1] = CFrame["new"](-16927.451, 9.086, 433.864)
                    TeleportToTarget(L_1241_[1])
                    if (L_1241_[1]["Position"] - L_1_[45]["Character"]["HumanoidRootPart"]["Position"])["Magnitude"] <= 10 then
                        L_1_[18]["Remotes"]["CommF_"]:InvokeServer("BuyBoat", _G["SelectedBoat"])
                    end
                elseif L_1240_[2] and (not(CheckShark() and _G["Shark"] or CheckTerrorShark() and _G["TerrorShark"] or CheckFishCrew() and _G["MobCrew"] or CheckPiranha() and _G["Piranha"]) and (not(CheckEnemiesBoat() and _G["FishBoat"]) and (not(CheckSeaBeast() and _G["SeaBeast1"]) and (not(_G["PGB"] and CheckPirateGrandBrigade()) and (not(_G["HCM"] and CheckHauntedCrew()) and not(_G["Leviathan1"] and CheckLeviathan())))))) then
                    if L_1_[45]["Character"]["Humanoid"]["Sit"] == false then
                        local L_1242_ = {}
                        L_1242_[2] = L_1240_[2]["VehicleSeat"]["CFrame"] * CFrame["new"](0, 1, 0)
                        _tp(L_1242_[2])
                    else
                        if _G["DangerSc"] == "Lv 1" then
                            CFrameSelectedZone = CFrame["new"](-21998.375, 30.0006084, -682.309143)
                        elseif _G["DangerSc"] == "Lv 2" then
                            CFrameSelectedZone = CFrame["new"](-26779.5215, 30.0005474, -822.858032)
                        elseif _G["DangerSc"] == "Lv 3" then
                            CFrameSelectedZone = CFrame["new"](-31171.957, 30.0001011, -2256.93774)
                        elseif _G["DangerSc"] == "Lv 4" then
                            CFrameSelectedZone = CFrame["new"](-34054.6875, 30.2187767, -2560.12012)
                        elseif _G["DangerSc"] == "Lv 5" then
                            CFrameSelectedZone = CFrame["new"](-38887.5547, 30.0004578, -2162.99023)
                        elseif _G["DangerSc"] == "Lv 6" then
                            CFrameSelectedZone = CFrame["new"](-44541.7617, 30.0003204, -1244.8584)
                        elseif _G["DangerSc"] == "Lv Infinite" then
                            CFrameSelectedZone = CFrame["new"](-10000000, 31, 37016.25)
                        end
                        repeat
                            wait()
                            if not _G["FishBoat"] and CheckEnemiesBoat() or not _G["PGB"] and CheckPirateGrandBrigade() or not _G["TerrorShark"] and CheckTerrorShark() then
                                _tp(CFrameSelectedZone * CFrame["new"](0, 150, 0))
                            else
                                _tp(CFrameSelectedZone)
                            end
                        until _G["SailBoats"] == false or CheckShark() and _G["Shark"] or CheckTerrorShark() and _G["TerrorShark"] or CheckFishCrew() and _G["MobCrew"] or CheckPiranha() and _G["Piranha"] or CheckSeaBeast() and _G["SeaBeast1"] or CheckEnemiesBoat() and _G["FishBoat"] or _G["Leviathan1"] and CheckLeviathan() or _G["HCM"] and CheckHauntedCrew() or _G["PGB"] and CheckPirateGrandBrigade() or (L_1_[45]["Character"]:WaitForChild("Humanoid"))["Sit"] == false
                        L_1_[45]["Character"]["Humanoid"]["Sit"] = false
                    end
                end
            end)
        end
    end
end)

-- Boat collision handling
spawn(function()
    while wait(Sec) do
        pcall(function()
            for L_1243_forvar0, L_1244_forvar1 in pairs(workspace["Boats"]:GetChildren()) do
                local L_1245_ = {}
                L_1245_[3], L_1245_[2] = L_1243_forvar0, L_1244_forvar1
                for L_1246_forvar0, L_1247_forvar1 in pairs(workspace["Boats"][L_1245_[2]["Name"]]:GetDescendants()) do
                    local L_1248_ = {}
                    L_1248_[1], L_1248_[2] = L_1246_forvar0, L_1247_forvar1
                    if L_1248_[2]:IsA("BasePart") then
                        if _G["SailBoats"] or _G["Prehis_Find"] or _G["FindMirage"] or _G["SailBoat_Hydra"] or _G["AutofindKitIs"] then
                            L_1248_[2]["CanCollide"] = false
                        else
                            L_1248_[2]["CanCollide"] = true
                        end
                    end
                end
            end
        end)
    end
end)

-- Auto Shark
spawn(function()
    while wait() do
        pcall(function()
            if _G["Shark"] then
                local L_1265_ = {}
                L_1265_[2] = {
                    "Shark"
                }
                if CheckShark() then
                    for L_1266_forvar0, L_1267_forvar1 in pairs(workspace["Enemies"]:GetChildren()) do
                        local L_1268_ = {}
                        L_1268_[2], L_1268_[3] = L_1266_forvar0, L_1267_forvar1
                        if table["find"](L_1265_[2], L_1268_[3]["Name"]) then
                            if L_1_[4]["Alive"](L_1268_[3]) then
                                repeat
                                    task["wait"]()
                                    L_1_[4]["Kill"](L_1268_[3], _G["Shark"])
                                until _G["Shark"] == false or not L_1268_[3]["Parent"] or L_1268_[3]["Humanoid"]["Health"] <= 0
                            end
                        end
                    end
                end
            end
            if _G["TerrorShark"] then
                local L_1269_ = {}
                L_1269_[2] = {
                    "Terrorshark"
                }
                if CheckTerrorShark() then
                    for L_1270_forvar0, L_1271_forvar1 in pairs(workspace["Enemies"]:GetChildren()) do
                        local L_1272_ = {}
                        L_1272_[2], L_1272_[1] = L_1270_forvar0, L_1271_forvar1
                        if table["find"](L_1269_[2], L_1272_[1]["Name"]) then
                            if L_1_[4]["Alive"](L_1272_[1]) then
                                repeat
                                    task["wait"]()
                                    L_1_[4]["KillSea"](L_1272_[1], _G["TerrorShark"])
                                until _G["TerrorShark"] == false or not L_1272_[1]["Parent"] or L_1272_[1]["Humanoid"]["Health"] <= 0
                            end
                        end
                    end
                end
            end
            if _G["Piranha"] then
                local L_1273_ = {}
                L_1273_[1] = {
                    "Piranha"
                }
                if CheckPiranha() then
                    for L_1274_forvar0, L_1275_forvar1 in pairs(workspace["Enemies"]:GetChildren()) do
                        local L_1276_ = {}
                        L_1276_[1], L_1276_[2] = L_1274_forvar0, L_1275_forvar1
                        if table["find"](L_1273_[1], L_1276_[2]["Name"]) then
                            if L_1_[4]["Alive"](L_1276_[2]) then
                                repeat
                                    task["wait"]()
                                    L_1_[4]["Kill"](L_1276_[2], _G["Piranha"])
                                until _G["Piranha"] == false or not L_1276_[2]["Parent"] or L_1276_[2]["Humanoid"]["Health"] <= 0
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- Aimbot Method Skills - Aim Player
spawn(function()
    while wait() do
        pcall(function()
            if _G["AimMethod"] and ABmethod == "Aim Player" then
                local L_1570_ = {}
                L_1570_[1] = L_1_[59]:FindFirstChild((getgenv())["PlayersList"])
                if L_1570_[1] and (L_1570_[1]["Character"] and L_1570_[1]["Character"]:FindFirstChild("HumanoidRootPart")) then
                    if L_1570_[1]["Team"] ~= L_1_[42]["Team"] then
                        MousePos = L_1570_[1]["Character"]["HumanoidRootPart"]["Position"]
                    end
                end
            end
        end)
    end
end)

-- Aimbot Method Skills - Nearest Aim
spawn(function()
    while wait() do
        pcall(function()
            if _G["AimMethod"] and ABmethod == "Nearest Aim" then
                local L_1571_ = {}
                L_1571_[2] = math["huge"]
                for L_1572_forvar0, L_1573_forvar1 in pairs(L_1_[59]:GetPlayers()) do
                    local L_1574_ = {}
                    L_1574_[3], L_1574_[1] = L_1572_forvar0, L_1573_forvar1
                    if L_1574_[1] ~= L_1_[42] and (L_1574_[1]["Team"] ~= L_1_[42]["Team"] and (L_1574_[1]["Character"] and L_1574_[1]["Character"]:FindFirstChild("HumanoidRootPart"))) then
                        local L_1575_ = {}
                        L_1575_[2] = (L_1574_[1]["Character"]["HumanoidRootPart"]["Position"] - L_1_[42]["Character"]["HumanoidRootPart"]["Position"])["Magnitude"]
                        if L_1575_[2] < L_1571_[2] then
                            L_1571_[2] = L_1575_[2]
                            MousePos = L_1574_[1]["Character"]["HumanoidRootPart"]["Position"]
                        end
                    end
                end
            end
        end)
    end
end)

-- Aimbot Camera Closet Players
task["spawn"](function()
    while task["wait"](Sec) do
        pcall(function()
            if _G["AimCam"] then
                local L_1578_ = {}
                L_1578_[1] = workspace["CurrentCamera"]
                closestplayer = function()
                    local L_1579_ = {}
                    L_1579_[3] = math["huge"]
                    L_1579_[1] = nil
                    for L_1580_forvar0, L_1581_forvar1 in next, ply:GetPlayers() do
                        local L_1582_ = {}
                        L_1582_[2], L_1582_[3] = L_1580_forvar0, L_1581_forvar1
                        if L_1582_[3] ~= L_1_[42] then
                            if L_1582_[3]["Character"] and (L_1582_[3]["Character"]:FindFirstChild("Head") and (_G["AimCam"] and L_1582_[3]["Character"]["Humanoid"]["Health"] > 0)) then
                                local L_1583_ = {}
                                L_1583_[1] = (L_1582_[3]["Character"]["Head"]["Position"] - L_1_[42]["Character"]["Head"]["Position"])["Magnitude"]
                                if L_1583_[1] < L_1579_[3] then
                                    L_1579_[3] = L_1583_[1]
                                    L_1579_[1] = L_1582_[3]
                                end
                            end
                        end
                    end
                    return L_1579_[1]
                end
                repeat
                    task["wait"]()
                    L_1578_[1]["CFrame"] = CFrame["new"](L_1578_[1]["CFrame"]["Position"], (closestplayer())["Character"]["HumanoidRootPart"]["Position"])
                until _G["AimCam"] == false or Mag > dist
            end
        end)
    end
end)

-- Auto Get PlayerQuest
spawn(function()
    while task["wait"](1) do
        if _G["AutoReceivePlayerQuest"] then
            pcall(function()
                (game:GetService("ReplicatedStorage"))["Remotes"]["CommF_"]:InvokeServer("PlayerHunter")
            end)
        end
    end
end)

-- Auto Kill Player Quest
spawn(function()
    while task["wait"]() do
        if _G["AutoPlayerHunter"] then
            if game["Players"]["LocalPlayer"]["PlayerGui"]["Main"]["Quest"]["Visible"] == false then
                task["wait"](.5);
                (game:GetService("ReplicatedStorage"))["Remotes"]["CommF_"]:InvokeServer("PlayerHunter")
            else
                for L_1588_forvar0, L_1589_forvar1 in pairs((game:GetService("Workspace"))["Characters"]:GetChildren()) do
                    local L_1590_ = {}
                    L_1590_[1], L_1590_[3] = L_1588_forvar0, L_1589_forvar1
                    if string["find"](game["Players"]["LocalPlayer"]["PlayerGui"]["Main"]["Quest"]["Container"]["QuestTitle"]["Title"]["Text"], L_1590_[3]["Name"]) then
                        repeat
                            task["wait"]()
                            if AutoHaki then
                                AutoHaki()
                            end
                            if EquipWeapon then
                                EquipWeapon(_G["SelectWeapon"])
                            end
                            Useskill = true
                            _tp(L_1590_[3]["HumanoidRootPart"]["CFrame"] * CFrame["new"](1, 7, 3))
                            L_1590_[3]["HumanoidRootPart"]["Size"] = Vector3["new"](60, 60, 60);
                            (game:GetService("VirtualUser")):CaptureController();
                            (game:GetService("VirtualUser")):Button1Down(Vector2["new"](1280, 672))
                        until _G["AutoPlayerHunter"] == false or L_1590_[3]["Humanoid"]["Health"] <= 0
                        Useskill = false;
                        (game:GetService("ReplicatedStorage"))["Remotes"]["CommF_"]:InvokeServer("AbandonQuest")
                    end
                end
            end
        end
    end
end)

-- Auto Enable PvP
spawn(function()
    while task["wait"](.5) do
        if _G["AutoPvP"] then
            local L_1593_ = {}
            L_1593_[2] = game["Players"]["LocalPlayer"]["PlayerGui"]
            if L_1593_[2] and (L_1593_[2]["Main"] and L_1593_[2]["Main"]:FindFirstChild("PvpDisabled")) then
                if L_1593_[2]["Main"]["PvpDisabled"]["Visible"] then
                    pcall(function()
                        (game:GetService("ReplicatedStorage"))["Remotes"]["CommF_"]:InvokeServer("EnablePvp")
                    end)
                end
            end
        end
    end
end)

-- Auto Safe Mode
spawn(function()
    while task["wait"](.1) do
        if _G["SafeMode"] then
            local L_1596_ = {}
            L_1596_[1] = game["Players"]["LocalPlayer"]["Character"]
            L_1596_[2] = L_1596_[1] and L_1596_[1]:FindFirstChild("HumanoidRootPart")
            if L_1596_[2] then
                local L_1597_ = {}
                L_1597_[2] = L_1596_[2]["CFrame"] * CFrame["new"](0, 200, 0)
                _tp(L_1597_[2])
            end
        end
    end
end)

-- Day/Night time
task["spawn"](function()
    while task["wait"]() do
        if _G["daylightN"] then
            if _G["SelectDN"] == "Day" then
                Lighting["ClockTime"] = 12
            elseif _G["SelectDN"] == "Night" then
                Lighting["ClockTime"] = 0
            end
        end
    end
end)

-- Ice Walk
spawn(function()
    while task["wait"]() do
        if _G["WalkWater"] then
            pcall(function()
                if L_1_[42]["Character"] and L_1_[42]["Character"]:FindFirstChild("LeftFoot") then
                    local L_1730_ = {}
                    L_1730_[3] = L_1_[103]["Assets"]["Models"]["IceSpikes4"]:Clone()
                    L_1730_[3]["Parent"] = workspace
                    L_1730_[3]["Size"] = Vector3["new"](3 + math["random"](10, 12), 1.7, 3 + math["random"](10, 12))
                    L_1730_[3]["Color"] = Color3["fromRGB"](128, 187, 219)
                    L_1730_[3]["CFrame"] = CFrame["new"](L_1_[42]["Character"]["Head"]["Position"]["X"], -3.8, L_1_[42]["Character"]["Head"]["Position"]["Z"]) * CFrame["Angles"]((math["random"]() - .5) * .06, math["random"]() * 7, (math["random"]() - .5) * .07)
                    L_1730_[1] = {}
                    L_1730_[1]["Size"] = Vector3["new"](0, .3, 0)
                    L_1730_[2] = TW:Create(L_1730_[3], TweenInfo["new"](2, Enum["EasingStyle"]["Quad"], Enum["EasingDirection"]["In"]), L_1730_[1])
                    L_1730_[2]["Completed"]:Connect(function()
                        L_1730_[3]:Destroy()
                    end)
                    L_1730_[2]:Play()
                end
            end)
        end
    end
end)

-- Seriality Attack Loop
task["spawn"](function()
    RunSer["Heartbeat"]:Connect(function()
        pcall(function()
            local L_1767_ = {}
            if not _G["Seriality"] then
                return
            end
            AttackNoCoolDown()
            L_1767_[2] = game["Players"]["LocalPlayer"]["Character"]:FindFirstChildOfClass("Tool")
            L_1767_[5] = L_1767_[2]["ToolTip"]
            L_1767_[1], L_1767_[3] = get_Monster()
            if L_1767_[5] == "Blox Fruit" then
                if L_1767_[1] then
                    local L_1768_ = {}
                    L_1768_[2] = L_1767_[2]:FindFirstChild("LeftClickRemote")
                    if L_1768_[2] then
                        Actived()
                        L_1768_[2]:FireServer(Vector3["new"](.01, -500, .01), 1, true)
                        L_1768_[2]:FireServer(false)
                    end
                end
            end
        end)
    end)
end)

end -- End of EventsAndPVPModule.startLoops()

print("[EventsAndPVPModule] Loaded - Call EventsAndPVPModule.startLoops() to start automation")
return EventsAndPVPModule
