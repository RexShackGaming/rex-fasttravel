local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

-----------------------------------------------------------------
-- take money and send travel
-----------------------------------------------------------------
RegisterServerEvent('rex-fasttravel:server:buyticket')
AddEventHandler('rex-fasttravel:server:buyticket', function(data)
    local src = source
    
    -- Validate source
    if not src or src == 0 then
        return
    end
    
    -- Get player data
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then 
        print(('[rex-fasttravel] Warning: Player not found for source %s'):format(src))
        return 
    end
    
    -- Validate input data
    if not data or type(data) ~= 'table' then
        print(('[rex-fasttravel] Warning: Invalid data received from player %s'):format(Player.PlayerData.citizenid))
        return
    end
    
    local destination = data.destination
    local dest_label = data.dest_label
    local clientCost = data.cost
    local clientTravelTime = data.traveltime
    local playerPos = data.playerPos
    
    -- Validate required fields
    if not destination or type(destination) ~= 'vector3' then
        print(('[rex-fasttravel] Warning: Invalid destination from player %s'):format(Player.PlayerData.citizenid))
        return
    end
    
    if not Utils.IsValidDestination(destination) then
        print(('[rex-fasttravel] Warning: Destination not in config from player %s'):format(Player.PlayerData.citizenid))
        return
    end
    
    if not clientCost or type(clientCost) ~= 'number' or clientCost < 0 then
        print(('[rex-fasttravel] Warning: Invalid cost from player %s'):format(Player.PlayerData.citizenid))
        return
    end
    
    if not clientTravelTime or type(clientTravelTime) ~= 'number' or clientTravelTime < 0 then
        print(('[rex-fasttravel] Warning: Invalid travel time from player %s'):format(Player.PlayerData.citizenid))
        return
    end
    
    -- Server-side cost and wait time recalculation for security
    local serverCost = clientCost -- Default to client cost
    local serverTravelTime = clientTravelTime -- Default to client travel time
    
    -- Get current player position for server-side validation
    local currentPlayerPos = GetEntityCoords(GetPlayerPed(src))
    
    -- Use provided player position if valid, otherwise use current position
    local calcPos = currentPlayerPos
    if playerPos and type(playerPos) == 'vector3' then
        -- Allow small discrepancy for movement during menu interaction
        local posDistance = Utils.GetDistance(currentPlayerPos, playerPos)
        if posDistance <= 10.0 then -- Allow 10 unit tolerance
            calcPos = playerPos
        end
    end
    
    if Config.DynamicPricing then
        -- Recalculate cost server-side to prevent manipulation
        serverCost = Utils.CalculateTravelCost(calcPos, destination)
        
        -- Allow small cost variance (±$2) for rounding differences
        local costDifference = math.abs(serverCost - clientCost)
        if costDifference > 2 then
            print(('[rex-fasttravel] Warning: Cost manipulation detected from player %s (Client: $%d, Server: $%d)'):format(Player.PlayerData.citizenid, clientCost, serverCost))
            -- Use server-calculated cost instead
            TriggerClientEvent('ox_lib:notify', src, {
                title = 'Price Updated',
                description = ('Travel cost recalculated: $%d'):format(serverCost),
                type = 'inform',
                icon = 'fa-solid fa-calculator',
                duration = 5000
            })
        end
    end
    
    if Config.DynamicWaitTime then
        -- Recalculate wait time server-side to prevent manipulation
        serverTravelTime = Utils.CalculateTravelWaitTime(calcPos, destination)
        
        -- Allow small wait time variance (±2 seconds) for rounding differences
        local timeDifference = math.abs(serverTravelTime - clientTravelTime)
        if timeDifference > 2000 then -- 2000ms = 2 seconds tolerance
            print(('[rex-fasttravel] Warning: Wait time manipulation detected from player %s (Client: %dms, Server: %dms)'):format(Player.PlayerData.citizenid, clientTravelTime, serverTravelTime))
            -- Use server-calculated time instead
            TriggerClientEvent('ox_lib:notify', src, {
                title = 'Travel Time Updated',
                description = ('Travel time recalculated: %s'):format(Utils.FormatWaitTime(serverTravelTime)),
                type = 'inform',
                icon = 'fa-solid fa-clock',
                duration = 5000
            })
        end
    end
    
    -- Use server-calculated values for the transaction
    local cost = serverCost
    local traveltime = serverTravelTime
    
    -- Validate player money
    if not Player.PlayerData.money or not Player.PlayerData.money['cash'] then
        print(('[rex-fasttravel] Warning: Player money data not found for %s'):format(Player.PlayerData.citizenid))
        return
    end
    
    local cashBalance = Player.PlayerData.money['cash']
    
    if cashBalance >= cost then
        -- Remove money and initiate travel
        local success = Player.Functions.RemoveMoney('cash', cost, 'purchase-fasttravel')
        if success then
            TriggerClientEvent('rex-fasttravel:client:doTravel', src, destination, dest_label, traveltime)
            print(('[rex-fasttravel] Player %s traveled for $%d to %s'):format(Player.PlayerData.citizenid, cost, dest_label or 'Unknown'))
        else
            print(('[rex-fasttravel] Error: Failed to remove money from player %s'):format(Player.PlayerData.citizenid))
        end
    else 
        -- Insufficient funds notification
        TriggerClientEvent('ox_lib:notify', src, {
            title = locale('sv_lang_1'),
            description = locale('sv_lang_2') .. cost,
            type = 'error',
            icon = 'fa-solid fa-globe',
            iconAnimation = 'shake',
            duration = 7000
        })
    end
end)
