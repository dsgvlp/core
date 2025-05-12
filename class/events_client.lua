loadCore = loadCore or {}
loadCore.events = loadCore.events or {}
loadCore.events.list = loadCore.events.list or {}

function loadCore.events:server(eventName, ...)
    TriggerServerEvent(loadCore.events:getHash(eventName), ...)
end
