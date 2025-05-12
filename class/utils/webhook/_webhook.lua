loadCore = loadCore or {}

if IsDuplicityVersion() then
    loadCore.utils.log = function(webId, data)
        if not loadCore.webhook.urls[webId] then 
            Logger:Trace("The webId (" .. webId .. ") is not configured or does not exist.", "err")
            return
        end

        if not data.title then 
            Logger:Trace("A title is required to send a log.", "err")
            return
        end

        if not data.description then 
            Logger:Trace("A description is required to send a log.", "err")
            return
        end

        PerformHttpRequest(loadCore.webhook.urls[webId], function(err, text, headers) 
            if not (err == 200 or err == 204) then
                Logger:Trace("Error when sending a log, code: " .. tostring(err), "err")
            end
        end, "POST", json.encode({
            ["username"] = data.username or "Server Notification",
            ["avatar_url"] = data.avatar_url or "",
            ["embeds"] = {{
                ["title"] = data.title,
                ["description"] = data.description,
                ["color"] = data.color or 16711680,
                ["fields"] = data.fields or {},
                ["thumbnail"] = {
                    ["url"] = data.thumbnail_url or ""
                },
                ["footer"] = {
                    ["text"] = loadCore.utils.getFormattedDateTime(),
                    ["icon_url"] = data.footer_icon or ""
                }
            }}
        }), {["Content-Type"] = "application/json"})
    end

    local function getPlayerInfo(playerId, isTarget)
        local identifiers = loadCore.utils.getIdentifiers(playerId) 
        local info = string.format("**%s Info:**\n→ **Name**: %s\n→ **ID**: %s\n", 
            isTarget and "Target Player" or "Source Player", 
            GetPlayerName(playerId), 
            playerId)

        for identifier, value in pairs(identifiers) do
            if identifier == "discord" then 
                info = info..string.format("→ **%s**: <@%s>\n", loadCore.utils.capitalizeFirstLetter(identifier), value)
            else
                info = info..string.format("→ **%s**: %s\n", loadCore.utils.capitalizeFirstLetter(identifier), value)
            end
        end

        return info
    end

    loadCore.utils.playerLog = function(webId, data, source, target)
        data.description = getPlayerInfo(source).."\n"..(target ~= nil and getPlayerInfo(target, true).."\n" or "").."**Additional Info:**\n"..data.description
        loadCore.utils.log(webId, data)
    end

    loadCore.events:new("webhook:log", function(webId, data)
        loadCore.utils.log(webId, data)
    end)

    loadCore.events:new("webhook:playerLog", function(webId, data, source, target)
        loadCore.utils.playerLog(webId, data, source, target)
    end)

    exports("sendWebhookLog", function(webId, data)
        return loadCore.utils.log(webId, data)
    end)

    exports("sendPlayerLog", function(webId, data, source, target)
        return loadCore.utils.playerLog(webId, data, source, target)
    end)

    Logger:Trace("Webhook system initialized on server-side", "done")
else
    loadCore.utils.log = function(webId, data)
        loadCore.events:server("webhook:log", webId, data)
    end
    
    loadCore.utils.playerLog = function(webId, data, source, target)
        loadCore.events:server("webhook:playerLog", webId, data, source, target)
    end

    Logger:Trace("Webhook system initialized on client-side", "done")
end
