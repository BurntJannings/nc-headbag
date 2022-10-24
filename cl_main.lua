local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)


local headMask = false

RegisterNetEvent('RemoveHeadBag', function(player)
    DeleteEntity(Object)
    SetEntityAsNoLongerNeeded(Object)
    SendNUIMessage({
        ["action"] = "remove"
    })
    headMask = false
end)

RegisterCommand(Config.command, function()
    local _source = source
    if headMask then 
        TriggerServerEvent("nc-headbag:givebagback", _source)
        TriggerEvent("CheckThread")
    else
    end
    end)

RegisterNetEvent("StartThread", function(player)
     ped = PlayerPedId()
     
        Object = CreateObject(GetHashKey("p_bucket03x"), 0, 0, 0, true, true, true)
        AttachEntityToEntity(Object, ped, GetPedBoneIndex(ped, 21030), 0.2, 0-0.02, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
        SetEntityCompletelyDisableCollision(Object, false, true)
        SendNUIMessage({
            ["action"] = "open"
        })
        headMask = true
while headMask do
    Wait(10)
    if IsEntityDead(ped) then
     if not Config.RemoveonDeath then
        OnRespawn()
     else
        DeleteEntity(Object)
        SendNUIMessage({
            ["action"] = "remove"
        })
        break
    end
   end
end 

end)

AddEventHandler("playerSpawned", function()
    DeleteEntity(Object)
    SetEntityAsNoLongerNeeded(Object)
    headMask = false
end)

RegisterNetEvent("CheckThread")
AddEventHandler("CheckThread", function()
    local closestPlayer, closestDistance = GetClosestPlayer()
    local player = GetPlayerPed(-1)
    if closestPlayer == -1 or closestDistance > 2.0 then
        VORPcore.NotifyRightTip("No players nearby!",4000)

    else
        if not headMask then
                TriggerServerEvent("nc-headbag:getClosestPlayer", GetPlayerServerId(closestPlayer))
                headMask = true
        else
            TriggerServerEvent("nc-headbag:getClosestPlayer2", GetPlayerServerId(closestPlayer))
            headMask = false
        end
    end
end)

function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
    local playerPed, playerId = PlayerPedId(), PlayerId()
    local coords, usePlayerPed = coords, false
    
    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end
    
    for i=1, #players, 1 do
        local tgt = GetPlayerPed(players[i])
        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then

            local targetCoords = GetEntityCoords(tgt)
            local distance = #(coords - targetCoords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = players[i]
                closestDistance = distance
                playerid = GetPlayerServerId(players[i])
                tgt1 = GetPlayerPed(players[i])
            end
        end
    end
    return closestPlayer, closestDistance,  playerid, tgt1
end

function OnRespawn()
RegisterNetEvent("vorp:PlayerForceRespawn", function()
    print("THIS IS HAPPENING")
    DeleteEntity(Object)
    SetEntityAsNoLongerNeeded(Object)
    SendNUIMessage({
        ["action"] = "remove"
    })
    headMask = false
end)
end
