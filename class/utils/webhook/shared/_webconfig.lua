loadCore = loadCore or {}
loadCore.webhook = loadCore.webhook or {}
loadCore.webhook.urls = {}
loadCore.webhook.urls["main"] = ""

loadCore.webhook.inject = function(id, value)
    loadCore.webhook.urls[id] = value
end
