local QBCore = exports["qb-core"]:GetCoreObject()
local LoggedIn = false
local xSound = exports.xsound
local hunger = 0
local thirst = 0

Citizen.CreateThread(function()
    while QBCore.Functions.GetPlayerData().job == nil do 
        Wait(1500)
    end
    Wait(1500)
    LoggedIn = true
    PlayerData = QBCore.Functions.GetPlayerData()
    SendNUIMessage({type="loadhud"})
    UpdateStatuses()
    Wait(2000)
    exports["Renewed-Weaponscarry"]:RefreshWeapons()
end)

function UpdateStatuses()
    local health = (GetEntityHealth(cache.ped) - 100) / (GetEntityMaxHealth(cache.ped) - 100) * 100
    local armor = GetPedArmour(cache.ped)
    hunger = LocalPlayer.state.hunger
    thirst = LocalPlayer.state.thirst
    SendNUIMessage({
        type = 'updateStatus',
        health = math.floor(health),
        armor = math.floor(armor),
        thirst = math.floor(thirst),
        hunger = math.floor(thirst)
    })
end

local AlertStatus = {
    ['thirst'] = 30,
    ['hunger'] = 25
}
AddStateBagChangeHandler('thirst', ('player:%s'):format(cache.serverId), function(_, _, value)
    thirst = value
    if thirst <= AlertStatus['thirst'] then 
        TriggerEvent("ray-hud2:thirst:effect")
    end
    SendNUIMessage({
        type = 'updateStatus',
        thirst = math.floor(thirst),
    })
end)
AddStateBagChangeHandler('hunger', ('player:%s'):format(cache.serverId), function(_, _, value)
    hunger = value
    if hunger <= AlertStatus['hunger'] then 
        TriggerEvent("ray-hud2:hunger:effect")
    end
    SendNUIMessage({
        type = 'updateStatus',
        hunger = math.floor(hunger),
    })
end)
local hungerEffect = false
RegisterNetEvent("ray-hud2:hunger:effect", function()
    if not hungerEffect then 
        hungerEffect = true
        xSound:PlayUrl("hungerSound", "https://bigsoundbank.com/UPLOAD/ogg/1280.ogg", 0.35)
        Wait(60 * 1000)
        hungerEffect = false
    end
end)
local thirstEffect = false
RegisterNetEvent("ray-hud2:thirst:effect", function()
    if not thirstEffect then 
        Citizen.CreateThread(function()
            thirstEffect = true
            DoScreenFadeOut(200)
            Wait(500)
            DoScreenFadeIn(200)
            Wait(150)
            ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.3)
            Wait(1500)
            StopGameplayCamShaking()
            Wait(60 * 1000)
            thirstEffect = false
        end)
    end
end)

Citizen.CreateThread(function()
    while true do
        if LoggedIn then 
            local health = (GetEntityHealth(cache.ped) - 100) / (GetEntityMaxHealth(cache.ped) - 100) * 100
            local armor = GetPedArmour(cache.ped)

            SendNUIMessage({
                type = 'updateStatus',
                health = math.floor(health),
                armor = math.floor(armor)
            })
    
            Wait(500)
        else
            Wait(5500)
        end
    end
end)

local isTalking = false
Citizen.CreateThread(function()
    while true do 
        if LoggedIn then 
            if MumbleIsPlayerTalking(PlayerId()) ~= isTalking then 
                SendNUIMessage({
                    type = 'talking',
                    radio = exports["pma-voice"]:IsTalkingOnRadio(),
                    voice = MumbleIsPlayerTalking(PlayerId())
                })
                isTalking = MumbleIsPlayerTalking(PlayerId())
            end
            Wait(250)
        else
            Wait(5500)
        end
    end
end)

-- Automatic GPS Display
RegisterNetEvent("ray-hud2:gps", function(bool)
    DisplayRadar(bool)
end)
