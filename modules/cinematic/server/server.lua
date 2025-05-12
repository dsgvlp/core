loadCore = loadCore or {}
loadCore.cinematic = {}

function loadCore.cinematic:showToPlayer(playerId, text, playerName, duration)
    text = text or "Bienvenue"
    playerName = playerName or GetPlayerName(playerId)
    duration = duration or 5000
    
    loadCore.events:client("showCinematic", playerId, {
        text = text,
        playerName = playerName,
        duration = duration
    })
    
    loadCore.events:internal("cinematicShownToPlayer", playerId, text, playerName)
    
    return true
end

function loadCore.cinematic:showToAll(text, duration)
    text = text or "Bienvenue"
    duration = duration or 5000

    loadCore.events:all("showCinematic", {
        text = text,
        duration = duration
    })
    
    loadCore.events:internal("cinematicShownToAll", text)
    
    return true
end

loadCore.events:new("showCinematic", function(data)
    if data and data.text then
        exports["core"]:showCinematic(data.text, data.playerName, data.duration)
    end
end)

exports("showCinematicToPlayer", function(playerId, text, playerName, duration)
    return loadCore.cinematic:showToPlayer(playerId, text, playerName, duration)
end)

exports("showCinematicToAll", function(text, duration)
    return loadCore.cinematic:showToAll(text, duration)
end)

Logger:Trace("Module cinématique chargé", "done")