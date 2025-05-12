loadCore = loadCore or {}
loadCore.cinematic = {}

local isDisplaying = false
local nuiReady = false

Citizen.CreateThread(function()
    Wait(1000)
    nuiReady = true
    Logger:TraceClient("Module cinématique chargé", "done")
end)

function loadCore.cinematic:show(text, playerName, duration)
    if not nuiReady then return end
    
    text = text or "Bienvenue"
    playerName = playerName or GetPlayerName(PlayerId())
    duration = duration or 5000
    
    SendNUIMessage({
        type = "SHOW_CINEMATIC",
        state = true,
        text = text,
        playerName = playerName
    })
    
    isDisplaying = true
    if duration > 0 then
        Citizen.SetTimeout(duration, function()
            loadCore.cinematic:hide()
        end)
    end
    
    loadCore.events:internal("cinematicShown", text, playerName)
    
    return true
end

function loadCore.cinematic:hide()
    if not nuiReady or not isDisplaying then return end
    
    SendNUIMessage({
        type = "SHOW_CINEMATIC",
        state = false
    })
    
    isDisplaying = false
    loadCore.events:internal("cinematicHidden")
    
    return true
end

function loadCore.cinematic:isDisplaying()
    return isDisplaying
end

RegisterNUICallback("cinematicShown", function(data, cb)
    cb({ok = true})
end)

RegisterNUICallback("cinematicHidden", function(data, cb)
    cb({ok = true})
end)

AddEventHandler('playerSpawned', function()
    Citizen.SetTimeout(1000, function()
        local playerName = GetPlayerName(PlayerId())
        loadCore.cinematic:show("Bienvenue", playerName, 5000)
    end)
end)

exports("showCinematic", function(text, playerName, duration)
    return loadCore.cinematic:show(text, playerName, duration)
end)

exports("hideCinematic", function()
    return loadCore.cinematic:hide()
end)
