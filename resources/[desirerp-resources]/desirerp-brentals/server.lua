RegisterServerEvent('desirerp-bikerent:hasmoney')
AddEventHandler('desirerp-bikerent:hasmoney', function(price, vehicle)
    local vehicleName = vehicle
    local user = exports["desirerp-base"]:getModule("Player"):GetUser(source)
    local money = tonumber(user:getCash())
    if money >= price then
            user:removeMoney(price)
            TriggerClientEvent("desirerp-bikerent:spawnbike", user.source, vehicleName)
    else
            TriggerClientEvent('DoLongHudText', user.source, 'You dont have enough money on you!', 2)
    end
end)
