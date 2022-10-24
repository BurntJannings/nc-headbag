
local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

local VORPInv = {}

local headMask = false

VORPInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterNetEvent("nc-headbag:getClosestPlayer", function(closestPlayer)
    getPlayer = closestPlayer
    local name = GetPlayerName(getPlayer)
    TriggerClientEvent("StartThread", getPlayer)
end)

RegisterNetEvent("nc-headbag:getClosestPlayer2", function(closestPlayer)
    getPlayer = closestPlayer
    local name = GetPlayerName(getPlayer)
    TriggerClientEvent("RemoveHeadBag", getPlayer)
end)


VORPInv.RegisterUsableItem(Config.Item, function(data) --change name to item
    getPlayer = closestPlayer
    local _source = source
    VORPInv.subItem(data.source, Config.Item, 1) --change name to item
        TriggerClientEvent("CheckThread", data.source)
        headMask = true
end)


RegisterNetEvent("nc-headbag:givebagback", function()
    local _source = source
    VORPInv.addItem(_source, Config.Item, 1) --change name to item

end)
