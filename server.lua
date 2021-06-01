ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('ca:conteggio', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
			CopsConnected = CopsConnected + 1
		end
	end

	cb(CopsConnected)
end)

RegisterNetEvent("ca:pcshop")
AddEventHandler("ca:pcshop", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('gpu').count <= 1 and xPlayer.getMoney(1000) and xPlayer.getInventoryItem('cpu').count <= 1 and xPlayer.getInventoryItem('psu').count <= 1 and xPlayer.getInventoryItem('pcmaterial').count <= 2 and xPlayer.getInventoryItem('motherboard').count <= 1 then
                xPlayer.addInventoryItem('motherboard', 1)
                xPlayer.addInventoryItem('psu', 1)
                xPlayer.removeMoney(1000)
                xPlayer.addInventoryItem('cpu', 1)
                xPlayer.addInventoryItem('gpu', 1)
                xPlayer.addInventoryItem('pcmaterial', 2)
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Malzemeleri teslim aldın!'})
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Malzemeleri teslim alamadın!'})
            end
        end
    end)

RegisterNetEvent("ca:pcteslimat")
AddEventHandler("ca:pcteslimat", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then  
            if xPlayer.getInventoryItem('monsternotebook').count >= 2 then 
                xPlayer.addMoney(6500)
                xPlayer.removeInventoryItem('monsternotebook', 2)
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Teslimat başarılı 6500$ teslim aldın!'})
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Teslimat başarısız!'})
            end
        end
    end)

    RegisterNetEvent("ca:coin")
    AddEventHandler("ca:coin", function(item, count)
        local _source = source
        local xPlayer  = ESX.GetPlayerFromId(_source)
            if xPlayer ~= nil then  
                if xPlayer.getInventoryItem('gpu').count >= 1 and xPlayer.getMoney(2500) and xPlayer.getInventoryItem('motherboard').count >= 1 and xPlayer.getInventoryItem('psu').count >= 1 and xPlayer.getInventoryItem('cpu').count >= 1 and xPlayer.getInventoryItem('pcmaterial').count > 1 then 
                    xPlayer.removeInventoryItem('gpu', 1)
                    xPlayer.removeInventoryItem('cpu', 1)
                    xPlayer.removeInventoryItem('motherboard', 1)
                    xPlayer.removeInventoryItem('pcmaterial', 2)
                    xPlayer.removeInventoryItem('psu', 1)
                    xPlayer.removeMoney(2500)
                    xPlayer.addInventoryItem('minerpc', 1)
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'MinerPC elde ettin!'})
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'MinerPC bileşenlerine sahip değilsin!'})
                end
            end
        end)

        RegisterNetEvent("ca:comp")
        AddEventHandler("ca:comp", function(item, count)
            local _source = source
            local xPlayer  = ESX.GetPlayerFromId(_source)
                if xPlayer ~= nil then  
                    if xPlayer.getInventoryItem('gpu').count >= 1 and xPlayer.getMoney(250) and xPlayer.getInventoryItem('motherboard').count >= 1 and xPlayer.getInventoryItem('psu').count >= 1 and xPlayer.getInventoryItem('cpu').count >= 1 and xPlayer.getInventoryItem('pcmaterial').count > 1 then 
                        xPlayer.removeInventoryItem('gpu', 1)
                        xPlayer.removeInventoryItem('cpu', 1)
                        xPlayer.removeInventoryItem('motherboard', 1)
                        xPlayer.removeInventoryItem('pcmaterial', 2)
                        xPlayer.removeInventoryItem('psu', 1)
                        xPlayer.removeMoney(250)
                        xPlayer.addInventoryItem('monsternotebook', 2)
                        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'İki adet Notebook elde ettin!'})
                    else
                        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Gerekli bileşenlere sahip değilsin!'})
                    end
                end
            end)

ESX.RegisterServerCallback("ca:getMinerPc",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem("minerpc").count >= 1 then
		cb(true)
	else
		cb(false)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Senin MinerPC cihazına ihtiyacın var!'})
	end
end)

RegisterNetEvent("ca:success")
AddEventHandler("ca:success", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then  
            if xPlayer.getInventoryItem('minerpc').count >= 1 then 
                xPlayer.removeInventoryItem('minerpc', 1)
                xPlayer.addInventoryItem('scratchbtc', 4)
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Başardın!'})
            end
        end
    end)

RegisterNetEvent("ca:nopdnotify")
AddEventHandler("ca:nopdnotify", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then  
            if xPlayer.getInventoryItem('minerpc').count >= 1 then 
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Yeterli polis yok!'})
            end
        end
    end)

RegisterNetEvent("ca:unsuccess")
AddEventHandler("ca:unsuccess", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then  
            if xPlayer.getInventoryItem('minerpc').count >= 1 then 
                xPlayer.removeInventoryItem('minerpc', 1)
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Başaramadın!'})
            end
        end
    end)

    ESX.RegisterUsableItem('scratchbtc', function(source)
        local Player = ESX.GetPlayerFromId(source)
        TriggerClientEvent('btc:view', source)
        Player.removeInventoryItem('scratchbtc', 1)
      end)
      
      RegisterServerEvent('btc:dispenseReward')
      AddEventHandler('btc:dispenseReward', function(amount)
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addMoney(amount)
      
        if Config.GiveUsedScratchbtcAfterUse then
          xPlayer.addInventoryItem('scratchbtc_used', 1)
        end
      end)
      
      RegisterServerEvent('btc:dispenseUsedScratchbtc')
      AddEventHandler('btc:dispenseUsedScratchbtc', function()
        local xPlayer = ESX.GetPlayerFromId(source)
        
        if Config.GiveUsedScratchbtcAfterUse then
          xPlayer.addInventoryItem('scratchbtc_used', 1)
        end
      end)

