--[[
    Task Manager Module - Priority Queue System
    Ensures only one main action runs at a time
    Blox Fruits Script by Zlex Hub
]]

local TaskManager = {}

local Utils = nil

function TaskManager.Init(utils)
    Utils = utils
end

local RunService = game:GetService("RunService")

TaskManager.CurrentTask = nil
TaskManager.TaskQueue = {}
TaskManager.IsRunning = false
TaskManager.LoopConnection = nil

TaskManager.Priorities = {
    ["Sea Events"] = 1,
    ["Boss Farm"] = 2,
    ["Raid"] = 3,
    ["Race V4"] = 4,
    ["Mastery Farm"] = 5,
    ["Auto Farm"] = 6,
    ["Collect Items"] = 7,
    ["Collect Materials"] = 8,
}

TaskManager.ActiveTasks = {}

TaskManager.TaskCallbacks = {}

function TaskManager.RegisterTask(taskName, callback, priority)
    priority = priority or TaskManager.Priorities[taskName] or 99
    TaskManager.TaskCallbacks[taskName] = {
        callback = callback,
        priority = priority
    }
end

function TaskManager.SetTaskActive(taskName, active)
    TaskManager.ActiveTasks[taskName] = active
    if active then
        print("[TaskManager] Task enabled: " .. taskName)
    else
        print("[TaskManager] Task disabled: " .. taskName)
        if TaskManager.CurrentTask == taskName then
            TaskManager.CurrentTask = nil
        end
    end
end

function TaskManager.IsTaskActive(taskName)
    return TaskManager.ActiveTasks[taskName] == true
end

function TaskManager.GetHighestPriorityTask()
    local bestTask = nil
    local bestPriority = 999
    
    for taskName, isActive in pairs(TaskManager.ActiveTasks) do
        if isActive then
            local taskData = TaskManager.TaskCallbacks[taskName]
            if taskData and taskData.priority < bestPriority then
                bestPriority = taskData.priority
                bestTask = taskName
            end
        end
    end
    
    return bestTask
end

function TaskManager.GetCurrentTask()
    return TaskManager.CurrentTask
end

function TaskManager.CanRunTask(taskName)
    if not TaskManager.IsTaskActive(taskName) then
        return false
    end
    
    local highestPriority = TaskManager.GetHighestPriorityTask()
    return highestPriority == taskName
end

function TaskManager.ShouldYield(taskName)
    local currentHighest = TaskManager.GetHighestPriorityTask()
    if not currentHighest then return false end
    
    local myPriority = TaskManager.Priorities[taskName] or 99
    local highestPriority = TaskManager.Priorities[currentHighest] or 99
    
    return highestPriority < myPriority
end

function TaskManager.RunLoop()
    if TaskManager.IsRunning then return end
    TaskManager.IsRunning = true
    
    spawn(function()
        while TaskManager.IsRunning do
            local taskName = TaskManager.GetHighestPriorityTask()
            
            if taskName and taskName ~= TaskManager.CurrentTask then
                TaskManager.CurrentTask = taskName
                print("[TaskManager] Switching to: " .. taskName)
            end
            
            if taskName then
                local taskData = TaskManager.TaskCallbacks[taskName]
                if taskData and taskData.callback then
                    pcall(taskData.callback)
                end
            end
            
            task.wait(0.1)
        end
    end)
end

function TaskManager.StopLoop()
    TaskManager.IsRunning = false
    TaskManager.CurrentTask = nil
end

function TaskManager.GetStatus()
    local active = {}
    for name, isActive in pairs(TaskManager.ActiveTasks) do
        if isActive then
            table.insert(active, name)
        end
    end
    
    return {
        current = TaskManager.CurrentTask,
        active = active,
        running = TaskManager.IsRunning
    }
end

_G.TaskManager = TaskManager

return TaskManager
