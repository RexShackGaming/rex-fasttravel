local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

-----------------------------------------------------------------
-- Variables
-----------------------------------------------------------------
local blips = {}
local prompts = {}

local function createBlips()
    for _, location in pairs(Config.FastTravelLocations) do
        if location.showblip then
            local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, location.coords)
            if blip then
                SetBlipSprite(blip, joaat(Config.Blip.blipSprite), true)
                SetBlipScale(blip, Config.Blip.blipScale)
                Citizen.InvokeNative(0x9CB1A1623062F402, blip, Config.Blip.blipName)
                blips[#blips + 1] = blip
            end
        end
    end
end

local function createPrompts()   
    for _, location in pairs(Config.FastTravelLocations) do
        
        local prompt = exports['rsg-core']:createPrompt(
            location.location, 
            location.coords, 
            RSGCore.Shared.Keybinds[Config.Keybind], 
            locale('cl_lang_1') .. location.name, 
            {
                type = 'client',
                event = 'rex-fasttravel:client:menu',
            }
        )
        
        if prompt then
            prompts[#prompts + 1] = prompt
        else
            print('[rex-fasttravel] Failed to create prompt for', location.name)
        end
    end
end

CreateThread(function()
    createBlips()
    createPrompts()
end)

-----------------------------------------------------------------
-- fast travel menu
-----------------------------------------------------------------
RegisterNetEvent('rex-fasttravel:client:menu', function()

    -- Check if Utils is available
    if not Utils then
        print('[rex-fasttravel] Error: Utils not available')
        print('[rex-fasttravel] _G.Utils:', _G.Utils)
        print('[rex-fasttravel] Utils:', Utils)
        return
    end

    -- Check config availability
    if not Config then
        print('[rex-fasttravel] Error: Config not available')
        return
    end
    
    if not Config.FastTravel then
        print('[rex-fasttravel] Error: Config.FastTravel not available')
        return
    end

    local playerPed = cache.ped
    local playerPos = GetEntityCoords(playerPed)
    local options = {}

    for i, destination in ipairs(Config.FastTravel) do
        
        if destination.destination then
            -- Calculate distance-based values
            local distance = Utils.GetDistance(playerPos, destination.destination)
            local distanceCategory = Utils.GetDistanceCategory(distance)

            -- Cost: prefer dynamic; if disabled or missing, fall back gracefully
            local cost
            if Config.DynamicPricing then
                cost = Utils.CalculateTravelCost(playerPos, destination.destination)
            else
                cost = destination.cost or Config.Pricing.minimumCost or 10
            end

            -- Wait time: prefer dynamic; if disabled or missing, fall back gracefully
            local waitTime
            if Config.DynamicWaitTime then
                waitTime = Utils.CalculateTravelWaitTime(playerPos, destination.destination)
            else
                waitTime = destination.traveltime or Config.WaitTime.baseWaitTime or 30000
            end

            local formattedWaitTime = Utils.FormatWaitTime(waitTime)
            -- Create menu option with pricing and timing
            local title = destination.title
            local description = ''

            if Config.DynamicPricing and Config.DynamicWaitTime then
                title = ('%s - $%d'):format(destination.title, cost)
                description = ('Distance: %.0f units (%s) • Travel Time: %s'):format(distance, distanceCategory, formattedWaitTime)
            elseif Config.DynamicPricing then
                title = ('%s - $%d'):format(destination.title, cost)
                description = ('Distance: %.0f units (%s) • Travel Time: %s'):format(distance, distanceCategory, Utils.FormatWaitTime(destination.traveltime or waitTime))
            elseif Config.DynamicWaitTime then
                title = ('%s - $%d'):format(destination.title, cost)
                description = ('Travel Time: %s'):format(formattedWaitTime)
            else
                title = ('%s - $%d'):format(destination.title, cost)
                description = ('Travel Time: %s'):format(Utils.FormatWaitTime(waitTime))
            end

            options[#options + 1] = {
                title = title,
                description = description,
                icon = 'fas fa-map-marked-alt',
                serverEvent = 'rex-fasttravel:server:buyticket',
                args = {
                    destination = destination.destination,
                    cost = cost,
                    traveltime = waitTime,
                    dest_label = destination.dest_label,
                    playerPos = playerPos
                }
            }
        else
            print(('[rex-fasttravel] Skipping destination %d - no valid coords'):format(i))
        end
    end

    if #options > 0 then
        
        local menuTitle = locale('cl_lang_2') or 'Fast Travel Menu'
        if Config.DynamicPricing or Config.DynamicWaitTime then
            menuTitle = menuTitle
        end
        
        lib.registerContext({
            id = 'fasttravel_menu',
            title = menuTitle,
            options = options
        })
        lib.showContext('fasttravel_menu')
    else
        TriggerEvent('ox_lib:notify', {
            title = 'Fast Travel Error',
            description = 'No destinations available. Check console for details.',
            type = 'error',
            duration = 5000
        })
    end
end)

-----------------------------------------------------------------
-- do fasttravel
-----------------------------------------------------------------
RegisterNetEvent('rex-fasttravel:client:doTravel', function(destination, label, waitTime)
    if not destination or type(destination) ~= 'vector3' then
        return
    end
    
    if not waitTime or waitTime < 0 then
        waitTime = 5000 -- Default 5 seconds
    end
    
    -- Play travel sound
    PlaySoundFrontend("Gain_Point", "HUD_MP_PITP", true, 1)
    
    -- Show loading screen with destination label
    Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, label or 'Fast Travel', '', '')
    
    -- Wait for travel time
    Wait(waitTime)
    
    -- Teleport player to destination
    Citizen.InvokeNative(0x203BEFFDBE12E96A, cache.ped, destination)
    
    -- Clear loading screen and fade in
    Citizen.InvokeNative(0x74E2261D2A66849A, 0)
    Citizen.InvokeNative(0xA657EC9DBC6CC900, -1868977180)
    Citizen.InvokeNative(0xE8770EE02AEE45C2, 0)
    ShutdownLoadingScreen()
    DoScreenFadeIn(1000)
    Wait(1000)
end)

-----------------------------------------------------------------
-- Resource cleanup
-----------------------------------------------------------------
AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        -- Remove all blips
        for i = 1, #blips do
            if DoesBlipExist(blips[i]) then
                RemoveBlip(blips[i])
            end
        end
        
        -- Clear arrays
        blips = {}
        prompts = {}
    end
end)
