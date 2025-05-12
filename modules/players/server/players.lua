loadCore.events:basic("playerConnecting", function(name, setKickReason, deferrals)
    deferrals.defer()
    Wait(0)
    deferrals.update("Vérification de votre connexion...")
    Logger:Trace("Player : " .. name .. " is connecting.", "info")
    Wait(1000)
    deferrals.done()
    loadCore.events:internal("playerConnected", name, source)
end)

loadCore.events:basic("playerDropped", function(reason)
    local playerId = source
    local playerName = GetPlayerName(playerId) or "Unknown"
    Logger:Trace("Player : " .. playerName .. " has disconnected. Reason: " .. reason, "info")
    loadCore.events:internal("playerDisconnected", playerId, playerName, reason)
end)

loadCore.events:handler("playerConnected", function(name, playerId)
    loadCore.events:all("notification", name .. " a rejoint le serveur")
end)

loadCore.events:handler("playerDisconnected", function(playerId, playerName, reason)
    loadCore.events:all("notification", playerName .. " a quitté le serveur")
end)

Logger:Trace("Module players chargé", "done")
