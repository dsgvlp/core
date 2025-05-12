loadCore = loadCore or {}
loadCore.utils = {}

loadCore.utils.groupDigits = function(value)
    local left, num, right = string.match(value, "^([^%d]*%d)(%d*)(.-)$")
    if not left or not num or not right then
        return value
    end
    local formattedNum = num:reverse():gsub("(%d%d%d)", "%1 "):reverse()

    if formattedNum:sub(1, 1) == " " then
        formattedNum = formattedNum:sub(2)
    end
    return left..formattedNum..right
end

loadCore.utils.trim = function(value)
    if value then
        return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
    else
        return nil
    end
end

loadCore.utils.round = function(value, numDecimalPlaces)
    if numDecimalPlaces then
        local power = 10 ^ numDecimalPlaces
        return math.floor((value * power) + 0.5) / power
    else
        return math.floor(value + 0.5)
    end
end

loadCore.utils.sizeOf = function(t)
    local size = 0
    for _,_ in pairs(t) do 
        size = size + 1
    end
    return size
end

loadCore.utils.genPlate = function()
    local format = ""
    local characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    for i = 1, 8 do
        local charIndex = math.random(1, #characters)
        format = format .. string.sub(characters, charIndex, charIndex)
    end
    return format
end

loadCore.utils.rgbToDecimal = function(r, g, b)
    return (r * 256^2) + (g * 256) + b
end

loadCore.utils.capitalizeFirstLetter = function(str)
    return str:gsub("^%l", string.upper)
end

loadCore.utils.getFormattedDateTime = function()
    return os.date("%d/%m/%Y - %H:%M:%S")
end

loadCore.utils.getIdentifiers = function(playerId)
    local identifiers = {}
    
    for i = 0, GetNumPlayerIdentifiers(playerId) - 1 do
        local identifier = GetPlayerIdentifier(playerId, i)
        
        if identifier then
            local colonSplit = string.find(identifier, ":")
            local identifierType = string.sub(identifier, 1, colonSplit - 1)
            local identifierValue = string.sub(identifier, colonSplit + 1)
            
            identifiers[identifierType] = identifierValue
        end
    end
    
    return identifiers
end