loadCore = loadCore or {}
loadCore.events = {}
loadCore.events.list = {}

function loadCore.events:getHash(eventName)
    return ("loadCore:"..GetHashKey(eventName))
end

function loadCore.events:new(eventName, handler)
    local eventHash = loadCore.events:getHash(eventName)
    if not loadCore.events.list[eventHash] then 
        RegisterNetEvent(eventHash)
        loadCore.events.list[eventHash] = true
    end
    AddEventHandler(eventHash, handler)
end

function loadCore.events:handler(eventName, handler)
    AddEventHandler(loadCore.events:getHash(eventName), handler)
end

function loadCore.events:basic(eventName, handler)
    AddEventHandler(eventName, handler)
end

function loadCore.events:internal(eventName, ...)
    TriggerEvent(loadCore.events:getHash(eventName), ...)
end
