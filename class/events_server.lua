loadCore = loadCore or {}
loadCore.events = loadCore.events or {}
loadCore.events.list = loadCore.events.list or {}

function loadCore.events:client(eventName, source, ...)
    TriggerClientEvent(loadCore.events:getHash(eventName), source, ...)
end

function loadCore.events:all(eventName, ...)
    TriggerClientEvent(loadCore.events:getHash(eventName), -1, ...)
end
