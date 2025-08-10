local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

-----------------------------------------------------------------
-- take money and send travel
-----------------------------------------------------------------
RegisterServerEvent('rex-fasttravel:server:buyticket')
AddEventHandler('rex-fasttravel:server:buyticket', function(data)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    local destination = data.destination
    local dest_label = data.dest_label
    local cost = data.cost
    local traveltime = data.traveltime
    local cashBalance = Player.PlayerData.money["cash"]
    if cashBalance >= cost then
        Player.Functions.RemoveMoney("cash", cost, "purchase-fasttravel")
        TriggerClientEvent('rex-fasttravel:client:doTravel', src, destination, dest_label, traveltime)
    else 
        TriggerClientEvent('ox_lib:notify', src, 
            { 
                title = locale('sv_lang_1'),
                description = locale('sv_lang_2')..cost,
                type = 'error',
                icon = 'fa-solid fa-globe',
                iconAnimation = 'shake',
                duration = 7000
            }
        )
    end
end)
