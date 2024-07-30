--NOT THE CONFIG. DO NOT TOUCH--

local adsConfig = {}

local function loadAdsConfig()
    local ads = LoadResourceFile(GetCurrentResourceName(), 'ads_config.json')
    if ads then
        adsConfig = json.decode(ads)
    end
end

RegisterCommand('ad', function(source, args, rawCommand)
    local id = tonumber(args[1])
    local location = table.concat(args, " ", 2)
    
    if not id then
        TriggerClientEvent('chat:addMessage', source, {
            args = { '^1TheRealStudios.xyz', 'Invalid ad ID.' }
        })
        return
    end

    local ad = adsConfig[id]
    if not ad then
        TriggerClientEvent('chat:addMessage', source, {
            args = { '^1TheRealStudios.xyz', 'Ad not found.' }
        })
        return
    end

    if location == "" then
        TriggerClientEvent('chat:addMessage', source, {
            args = { '^1TheRealStudios.xyz', 'Please provide a location or postal!' }
        })
        return
    end

    TriggerClientEvent('chat:addMessage', -1, {
        args = { '^4' .. ad.department, ad.message .. ' Location: ' .. location }
    })
end, false)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        loadAdsConfig()
    end
end)
