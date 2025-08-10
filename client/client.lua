local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

-----------------------------------------------------------------
-- prompts and blips
-----------------------------------------------------------------
Citizen.CreateThread(function()
    for _,v in pairs(Config.FastTravelLocations) do
        exports['rsg-core']:createPrompt(v.location, v.coords, RSGCore.Shared.Keybinds[Config.Keybind], locale('cl_lang_1') .. v.name, {
            type = 'client',
            event = 'rex-fasttravel:client:menu',
        })
        if v.showblip == true then
            local FastTravelBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(FastTravelBlip, joaat(Config.Blip.blipSprite), true)
            SetBlipScale(FastTravelBlip, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, FastTravelBlip, Config.Blip.blipName)
        end
    end
end)

-----------------------------------------------------------------
-- fast travel menu
-----------------------------------------------------------------
RegisterNetEvent('rex-fasttravel:client:menu', function(data)
    local options = {}
    for _,v in ipairs(Config.FastTravel) do
        table.insert(options, {
            title = v.title..' ($'..v.cost..')',
            icon = 'fas fa-map-marked-alt',
            serverEvent = 'rex-fasttravel:server:buyticket',
            args = {
                destination = v.destination,
                cost = v.cost,
                traveltime = v.traveltime,
                dest_label = v.dest_label
            }
        })
    end
    lib.registerContext({
        id = 'fasttravel_menu',
        title = locale('cl_lang_2'),
        options = options
    })
    lib.showContext('fasttravel_menu')
end)

-----------------------------------------------------------------
-- do fasttravel
-----------------------------------------------------------------
RegisterNetEvent('rex-fasttravel:client:doTravel')
AddEventHandler('rex-fasttravel:client:doTravel', function(travel, lable, waittime)
    PlaySoundFrontend("Gain_Point", "HUD_MP_PITP", true, 1)    
    local travelto = travel
    Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, lable, '', '')
    Wait(waittime)
    Citizen.InvokeNative(0x203BEFFDBE12E96A, cache.ped, travelto)
    Citizen.InvokeNative(0x74E2261D2A66849A, 0)
    Citizen.InvokeNative(0xA657EC9DBC6CC900, -1868977180)
    Citizen.InvokeNative(0xE8770EE02AEE45C2, 0)
    ShutdownLoadingScreen()
    DoScreenFadeIn(1000)
    Wait(1000)
end)
