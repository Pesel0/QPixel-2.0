
RegisterNetEvent('qpixel-smelter:getrefined_aluminium')
AddEventHandler('qpixel-smelter:getrefined_aluminium', function()
    if exports['qpixel-inventory']:hasEnoughOfItem('aluminium', 1) then
        FreezeEntityPosition(PlayerPedId(), true)
        local Evan1 = exports['qpixel-taskbar']:taskBar(5000, 'Turning Aluminium into refined Aluminium')
        if Evan1 == 100 then
            TriggerEvent('inventory:removeItem', 'aluminium', 1)
            TriggerEvent('player:receiveItem', 'refinedaluminium', 5)
            TriggerEvent('DoLongHudText', 'Successfully turned Aluminium into Refined Aluminium.', 1)
            FreezeEntityPosition(PlayerPedId(), false)
        else
            FreezeEntityPosition(PlayerPedId(), false)
        end
    else
        TriggerEvent('DoLongHudText', 'You do not have 1x Aluminium.', 2)
    end
end)

RegisterNetEvent('qpixel-smelter:getrefined_plastic')
AddEventHandler('qpixel-smelter:getrefined_plastic', function()
    if exports['qpixel-inventory']:hasEnoughOfItem('plastic', 1) then
        FreezeEntityPosition(PlayerPedId(), true)
        local Evan2 = exports['qpixel-taskbar']:taskBar(5000, 'Turning plastic into Refined Plastic')
        if Evan2 == 100 then
            TriggerEvent('inventory:removeItem', 'plastic', 1)
            TriggerEvent('player:receiveItem', 'refinedplastic', 5)
            TriggerEvent('DoLongHudText', 'Successfully turned Plastic into Refined Plastic', 1)
            FreezeEntityPosition(PlayerPedId(), false)
        else
            FreezeEntityPosition(PlayerPedId(), false)
        end
    else
        TriggerEvent('DoLongHudText', 'You do not have 1x Plastic', 1)
    end
end)

RegisterNetEvent('qpixel-smelter:getrefined_copper')
AddEventHandler('qpixel-smelter:getrefined_copper', function()
    if exports['qpixel-inventory']:hasEnoughOfItem('copper', 1) then
        FreezeEntityPosition(PlayerPedId(), true)
        local Evan3 = exports['qpixel-taskbar']:taskBar(5000, 'Turning Copper into refined Copper')
        if Evan3 == 100 then
            TriggerEvent('inventory:removeItem', 'copper', 1)
            TriggerEvent('player:receiveItem', 'refinedcopper', 5)
            TriggerEvent('DoLongHudText', 'Successfully turned Copper into refined Copper', 1)
            FreezeEntityPosition(PlayerPedId(), false)
        else
            FreezeEntityPosition(PlayerPedId(), false)
        end
    else
        TriggerEvent('DoLongHudText', 'You do not have 1x Copper', 1)
    end
end)

RegisterNetEvent('qpixel-smelter:getrefined_glass')
AddEventHandler('qpixel-smelter:getrefined_glass', function()
    if exports['qpixel-inventory']:hasEnoughOfItem('glass', 1) then
        FreezeEntityPosition(PlayerPedId(), true)
        local Evan4 = exports['qpixel-taskbar']:taskBar(5000, 'Turning Glass into Refined Glass')
        if Evan4 == 100 then
            TriggerEvent('inventory:removeItem', 'glass', 1)
            TriggerEvent('player:receiveItem', 'refinedglass', 5)
            TriggerEvent('DoLongHudText', 'Successfully turned Glass into Refined Glass')
            FreezeEntityPosition(PlayerPedId(), false)
        else
            FreezeEntityPosition(PlayerPedId(), false)
        end
    else
        TriggerEvent('DoLongHudText', 'You do not have 1x Glass', 1)
    end
end)

RegisterNetEvent('qpixel-smelter:getrefined_rubber')
AddEventHandler('qpixel-smelter:getrefined_rubber', function()
    if exports['qpixel-inventory']:hasEnoughOfItem('rubber', 1) then
        FreezeEntityPosition(PlayerPedId(), true)
        local Evan5 = exports['qpixel-taskbar']:taskBar(5000, 'Turning Rubber into Refined Rubber')
        if Evan5 == 100 then
            TriggerEvent('inventory:removeItem', 'rubber', 1)
            TriggerEvent('player:receiveItem', 'refinedrubber', 5)
            TriggerEvent('DoLongHudText', 'Successfully turned Rubber into Refined Rubber')
            FreezeEntityPosition(PlayerPedId(), false)
        else
            FreezeEntityPosition(PlayerPedId(), false)
        end
    else
        TriggerEvent('DoLongHudText', 'You do not have 1x Rubber', 1)
    end
end)

RegisterNetEvent('qpixel-smelter:getrefined_scrap')
AddEventHandler('qpixel-smelter:getrefined_scrap', function()
    if exports['qpixel-inventory']:hasEnoughOfItem('scrapmetal', 1) then
        FreezeEntityPosition(PlayerPedId(), true)
        local Evan6 = exports['qpixel-taskbar']:taskBar(5000, 'Turning Scrap Metal into Refined Scrap')
        if Evan6 == 100 then
            TriggerEvent('inventory:removeItem', 'scrapmetal', 1)
            TriggerEvent('player:receiveItem', 'refinedscrap', 5)
            TriggerEvent('DoLongHudText', 'Successfully turned Scrap Metal into Refined Rubber')
            FreezeEntityPosition(PlayerPedId(), false)
        else
            FreezeEntityPosition(PlayerPedId(), false)
        end
    else
        TriggerEvent('DoLongHudText', 'You do not have 1x Scrap Metal', 1)
    end
end)

RegisterNetEvent('qpixel-smelter:getrefined_steel')
AddEventHandler('qpixel-smelter:getrefined_steel', function()
    if exports['qpixel-inventory']:hasEnoughOfItem('steel', 1) then
        FreezeEntityPosition(PlayerPedId(), true)
        local Evan7 = exports['qpixel-taskbar']:taskBar(5000, 'Turning Steel into Refined Rubber')
        if Evan7 == 100 then
            TriggerEvent('inventory:removeItem', 'steel', 1)
            TriggerEvent('player:receiveItem', 'refinedsteel', 5)
            TriggerEvent('DoLongHudText', 'Successfully turned Steel into Refined Rubber')
            FreezeEntityPosition(PlayerPedId(), false)
        else
            FreezeEntityPosition(PlayerPedId(), false)
        end
    else
        TriggerEvent('DoLongHudText', 'You do not have 1x Steel', 1)
    end
end)

-- Context Menu --

RegisterNetEvent('qpixel-jobs:refined_materials')
AddEventHandler('qpixel-jobs:refined_materials', function()
    local RefineShit = {
        {
            title = "Get Refined Aluminium",
            description = "Requirements: 1x Aluminium",
            key = "ALUMINIUM",
            action = 'qpixel-jobs:make_alu',
        },
        {
            title = "Get Refined Plastic",
            description = "Requirements: 1x Plastic",
            key = "PLASTIC",
            action = 'qpixel-jobs:make_plas',
        },
        {
            title = "Get Refined Copper",
            description = "Requirements: 1x Copper",
            key = "Copper",
            action = 'qpixel-jobs:make_cop',
        },
        {
            title = "Get Refined Glass",
            description = "Requirements: 1x Glass",
            key = "Glass",
            action = 'qpixel-jobs:make_glas',
        },
        {
            title = "Get Refined Rubber",
            description = "Requirements: 1x Rubber",
            key = "Rubber",
            action = 'qpixel-jobs:make_rub',
        },
        {
            title = "Get Refined Scrap",
            description = "Requirements: 1x Scrap Metal",
            key = "Scrap",
            action = 'qpixel-jobs:make_scra',
        },
        {
            title = "Get Refined Steel",
            description = "Requirements: 1x Scrap Steel",
            key = "Steel",
            action = 'qpixel-jobs:make_stel',
        },
    }
    exports["qpixel-interface"]:showContextMenu(RefineShit)
end)

RegisterInterfaceCallback('qpixel-jobs:make_alu', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('qpixel-smelter:getrefined_aluminium')
end)

RegisterInterfaceCallback('qpixel-jobs:make_plas', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('qpixel-smelter:getrefined_plastic')
end)

RegisterInterfaceCallback('qpixel-jobs:make_cop', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('qpixel-smelter:getrefined_copper')
end)

RegisterInterfaceCallback('qpixel-jobs:make_glas', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('qpixel-smelter:getrefined_glass')
end)

RegisterInterfaceCallback('qpixel-jobs:make_rub', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('qpixel-smelter:getrefined_rubber')
end)

RegisterInterfaceCallback('qpixel-jobs:make_scra', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('qpixel-smelter:getrefined_scrap')
end)

RegisterInterfaceCallback('qpixel-jobs:make_stel', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('qpixel-smelter:getrefined_steel')
end)

-- Interact --

exports["qpixel-polytarget"]:AddBoxZone("smelter_shit", vector3(1111.36, -2009.1, 31.04), 5, 1.6, {
    heading=325,
    --debugPoly=true,
    minZ=29.24,
    maxZ=33.24
})

exports["qpixel-interact"]:AddPeekEntryByPolyTarget("smelter_shit", {{
    event = "qpixel-jobs:refined_materials",
    id = "smelter_shit",
    icon = "warehouse",
    label = "Use Smelter",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});
