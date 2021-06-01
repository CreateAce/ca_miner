local PlayerData                = {}
ESX                             = nil

local CaAktif = false
local caspwan = false
local MiningPCM = false
local HackingPCM = false
local firstspawn = false
local CaTeslimat = false
local impacts = 0
local kordi = vector2(-645.800, -287.208) -- Tekonoloji Dükkanı blip kordinatı
local kordi2 = vector2(1273.084, -1711.25) -- Bitcoin Mining blip kordinatı
local kordi3 = vector2(608.8795, -420.997) -- Elon Musk blip kordinatı
local kordi4 = vector2(-657.437, -854.388) -- Laptop Montaj blip kordinatı 
local kordi5 = vector2(610.7974, -3074.99) -- İtopya Depo blip kordinatı

local blip = AddBlipForCoord(kordi.x, kordi.y)
SetBlipSprite(blip, 459)
SetBlipDisplay(blip, 6)
SetBlipScale(blip, 0.9)
SetBlipColour(blip, 4)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Teknoloji Dükkanı")
EndTextCommandSetBlipName(blip)

local blip2 = AddBlipForCoord(kordi2.x, kordi2.y)
SetBlipSprite(blip2, 606)
SetBlipDisplay(blip2, 6)
SetBlipScale(blip2, 0.9)
SetBlipColour(blip2, 5)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Bitcoin Mining")
EndTextCommandSetBlipName(blip2)

local blip3 = AddBlipForCoord(kordi3.x, kordi3.y)
SetBlipSprite(blip3, 409)
SetBlipDisplay(blip3, 6)
SetBlipScale(blip3, 0.9)
SetBlipColour(blip3, 21)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Elon Musk")
EndTextCommandSetBlipName(blip3)

local blip4 = AddBlipForCoord(kordi4.x, kordi4.y)
SetBlipSprite(blip4, 521)
SetBlipDisplay(blip4, 6)
SetBlipScale(blip4, 0.9)
SetBlipColour(blip4, 14)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Laptop Montaj")
EndTextCommandSetBlipName(blip4)

local blip5 = AddBlipForCoord(kordi5.x, kordi5.y)
SetBlipSprite(blip5, 557)
SetBlipDisplay(blip5, 6)
SetBlipScale(blip5, 0.9)
SetBlipColour(blip5, 46)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("İtopya Depo")
EndTextCommandSetBlipName(blip5)

local locations = {
    { x = -628.839, y = -275.754, z = 35.577}, -- Sipariş kordinatı
}

local locationteslimat = {
    { x = 610.8585, y = -3076.99, z = 6.0692}, -- İtopya teslimat kordinatı
}

local locationss = {
    { x = 1275.655, y = -1710.36, z = 54.771}, -- Mining kordinatı
}

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end)  

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 0, 0, 0, 100)
end

local caspwan = false

Citizen.CreateThread(function()
    local hash = GetHashKey("ig_roccopelosi") -- Montaj ped

    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Citizen.Wait(100)
    end

    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end

    if caspwan == false then
        local npc = CreatePed(6, hash, 610.0041, -420.511, 23.744, 89.03, false, false) -- Montaj pedinin yaratıldığı kordinat
        SetEntityInvincible(npc, true)
        FreezeEntityPosition(npc, true)
        SetPedDiesWhenInjured(npc, false)
        SetPedCanRagdollFromPlayerImpact(npc, false)
        SetPedCanRagdoll(npc, false)
        SetEntityAsMissionEntity(npc, true, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        SetEntityDynamic(npc, true)
    end
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), 610.0041, -420.511, 24.744, true) < 2 then -- Ped kordinat
                DrawText3D(610.0041, -420.511, 24.744, " ~r~[E] ~w~MinerPC Montaj ~g~2500$") -- Yardımcı yazı
                    if IsControlJustReleased(1, 51) then
                        Citizen.Wait(15)
                        CaPc()                
            end
        end
    end
 end)



function CaPc()
    local elements = {
        {label = 'Bilgisayarı topla',   value = 'coin'},
        {label = 'Menüyü Kapat',       value = 'kapat'},

    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ca-coi', {
        title    = 'Mining',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'coin' then
           menu.close()
           giveanimation()
           exports['sway_taskbar']:taskBar(6500, "MinerPC Toplanıyor...") -- MinerPC toplarken alttaki bar saniye ve yazısı
           giveanimation()
            TriggerServerEvent("ca:coin")
            Citizen.Wait(15)
        elseif data.current.value == 'kapat' then
            menu.close()
        end
    end)
end

function giveanimation() 
    RequestAnimDict("mp_common")
    while not HasAnimDictLoaded("mp_common")do 
        Citizen.Wait(0)
    end;b=CreateObject(GetHashKey('prop_weed_bottle'),0,0,0,true)
    AttachEntityToEntity(b,PlayerPedId(),
    GetPedBoneIndex(PlayerPedId(),57005),0.13,0.02,0.0,-90.0,0,0,1,1,0,1,0,1)
    AttachEntityToEntity(p,l,GetPedBoneIndex(l,57005),0.13,0.02,0.0,-90.0,0,0,1,1,0,1,0,1)
    TaskPlayAnim(GetPlayerPed(-1),"mp_common","givetake1_a",8.0,-8.0,-1,0,0,false,false,false)
    TaskPlayAnim(l,"mp_common","givetake1_a",8.0,-8.0,-1,0,0,false,false,false)
    Wait(1550)
    DeleteEntity(b)
    ClearPedTasks(pid)
    ClearPedTasks(l)
end


Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            for i=1, #locations, 1 do
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 10 and CaAktif == false then
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 1 then
                        DrawText3D(-628.891, -275.856, 35.577, " ~r~[E] ~w~Siparis ~g~1000$") -- Sipariş yardımcı yazı
                            if IsControlJustReleased(1, 51) then
                                Animation()
                                Citizen.Wait(15)
                                CaAktif = true
                            end
                        end
            end
        end
    end
end)

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100 
    SetTextScale(0.35, 0.35)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextColour(255, 255, 255, 215)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()   
end

function Animation()
    Citizen.CreateThread(function()
        while impacts < 1 do
            Citizen.Wait(1)
		local ped = PlayerPedId()	
                RequestAnimDict("timetable@amanda@ig_2")
                FreezeEntityPosition(ped, true)
                TaskPlayAnim((ped), 'timetable@amanda@ig_2', 'ig_2_base_amanda', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
                exports['sway_taskbar']:taskBar(10500, "Siparişleriniz hazırlanıyor...") -- Sipariş alırken altta çıkan bar saniyesi ve yazısı
                SetEntityHeading(ped, 270.0)
                ClearPedTasks(ped)
                impacts = impacts+1
                if impacts == 1 then
                    FreezeEntityPosition(ped, false)
                    CaAktif = false
                    impacts = 0
                    Citizen.Wait(15)
                    TriggerServerEvent("ca:pcshop")
                    break
                end        
        end
    end)
end

function startMiningPCM()
    ESX.TriggerServerCallback('ca:conteggio', function(CopsConnected)
        if CopsConnected < Config.RequiredCopsMine then
            MiningPCM = false
            TriggerServerEvent("ca:nopdnotify")
		else
            ESX.TriggerServerCallback('ca:getMinerPc', function(minerpc)
                if minerpc then
                    MiningPCM = true
                    FreezeEntityPosition(player,true)
                    local player = PlayerPedId()
                    local playerPos = GetEntityCoords(player)
                        
                    local animDict = "random@atmrobberygen@male"
                    local animName = "idle_a"
                    
                    RequestAnimDict(animDict)
                    while not HasAnimDictLoaded(animDict) do
                        Citizen.Wait(0)
                    end
                    
                    exports['sway_taskbar']:taskBar(6500, "Cihaz hazırlanıyor...") -- Mining başlamadan önce çıkan bar saniyesi ve yazısı
                    TaskPlayAnim(player,animDict,animName,3.0,0.5,-1,31,1.0,0,0)
                    Citizen.Wait(5000)
                    TaskStartScenarioInPlace(player, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
                    Citizen.Wait(5000)
                    TriggerEvent("mhacking:show")
                    TriggerEvent("mhacking:start",4,20,miningEvent)		       end
	       end)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        if cooldown == true then
            Citizen.Wait(1800000) 
        cooldown = false
        end
    end
end)

local cooldown = false

function miningEvent(success)
	local player = PlayerPedId()
     Citizen.Wait(15)
    FreezeEntityPosition(player,false)
    TriggerEvent('mhacking:hide')
    Citizen.Wait(15)
    if success then
		TriggerServerEvent("ca:success")
        ESX.ShowNotification("MinerPC işlemi başarılı. Polis gelmeden kaç!")
        cooldown = true
    else
        ESX.ShowNotification("MinerPC işlemi başarısız. Polis gelmeden kaç!")
        TriggerServerEvent("ca:unsuccess")
	end
    cooldown = true
	ClearPedTasks(player)
	ClearPedSecondaryTask(player)	
	MiningPCM = false
	HackingPCM = false
    FinishedMining()
    Citizen.Wait(1800000) -- Bir kişinin mining eventi sonrasında (başarılı ya da başarısız olması önemli değil) yediği cooldown. -30 DK-
    cooldown = false
        end

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            for i=1, #locationss, 1 do
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationss[i].x, locationss[i].y, locationss[i].z, true) < 10 and CaAktif == false then
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), locationss[i].x, locationss[i].y, locationss[i].z, true) < 1 then
                        if not cooldown then
                        DrawText3D(1275.708, -1710.48, 54.771, " ~g~[E] ~r~Mininge ~r~basla") -- Mininge başlanacak alan yardımcı yazı
                            if IsControlJustReleased(1, 51) then
                                startMiningPCM()
                                Citizen.Wait(15)
                                MiningPCM = true
                                HackingPCM = true
                                                     end
                        end
                    end
            end
        end
    end
end)

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100 
    SetTextScale(0.35, 0.35)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextColour(255, 255, 255, 215)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()   
end

Citizen.CreateThread(function()
    local hash = GetHashKey("a_m_m_salton_02") -- Elon musk ped
  
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Citizen.Wait(100)
    end
  
    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end
  
    if firstspawn == false then
        local npc = CreatePed(6, hash, -657.437, -854.388, 23.502, 3.03, false, false) -- Pedin spawnlanacağı alan
        SetEntityInvincible(npc, true)
        FreezeEntityPosition(npc, true)
        SetPedDiesWhenInjured(npc, false)
        SetPedCanRagdollFromPlayerImpact(npc, false)
        SetPedCanRagdoll(npc, false)
        SetEntityAsMissionEntity(npc, true, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        SetEntityDynamic(npc, true)
    end
  end)
  
  Citizen.CreateThread(function()
    while true do
  local ped = PlayerPedId()
        Citizen.Wait(1)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), -657.437, -854.388, 23.502, true) < 2 then -- Montaj kordinat
                DrawText3D(-657.437, -854.388, 24.502, " ~r~[E] ~w~Laptop Montaj ~g~250$") -- Montaj yardımcı yazısı
                    if IsControlJustReleased(1, 51) then
                      CaMontaj()          
                      Citizen.Wait(15)      
            end
        end
    end
  end)
  
  
  
  function CaMontaj()
    local elements = {
        {label = 'Montaj işlemi',   value = 'comp'},
        {label = 'Menüyü Kapat',       value = 'kapat'},
  
    }
  
    ESX.UI.Menu.CloseAll()
  
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ca-com', {
        title    = 'Bilgisayarcı',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'comp' then
           menu.close()
           montajanim()
           exports['sway_taskbar']:taskBar(4000, "Montaj...")
           montajanim()
            TriggerServerEvent("ca:comp")
            Citizen.Wait(15)
        elseif data.current.value == 'kapat' then
            menu.close()
        end
    end)
  end
  
  function montajanim() 
    RequestAnimDict("mp_common")
    while not HasAnimDictLoaded("mp_common")do 
        Citizen.Wait(0)
    end;b=CreateObject(GetHashKey('prop_weed_bottle'),0,0,0,true)
    AttachEntityToEntity(b,PlayerPedId(),
    GetPedBoneIndex(PlayerPedId(),57005),0.13,0.02,0.0,-90.0,0,0,1,1,0,1,0,1)
    AttachEntityToEntity(p,l,GetPedBoneIndex(l,57005),0.13,0.02,0.0,-90.0,0,0,1,1,0,1,0,1)
    TaskPlayAnim(GetPlayerPed(-1),"mp_common","givetake1_a",8.0,-8.0,-1,0,0,false,false,false)
    TaskPlayAnim(l,"mp_common","givetake1_a",8.0,-8.0,-1,0,0,false,false,false)
    Wait(1550)
    DeleteEntity(b)
    ClearPedTasks(pid)
    ClearPedTasks(l)
  end

  Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            for i=1, #locationteslimat, 1 do
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locationteslimat[i].x, locationteslimat[i].y, locationteslimat[i].z, true) < 10 and CaTeslimat == false then
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), locationteslimat[i].x, locationteslimat[i].y, locationteslimat[i].z, true) < 1 then
                        DrawText3D(610.8362, -3077.01, 6.0692, " ~r~[E] ~w~Teslimat") -- Teslimat yardımcı yazı
                            if IsControlJustReleased(1, 51) then
                                Animationteslimat()
                                Citizen.Wait(15)
                                CaTeslimat = true
                            end
                        end
            end
        end
    end
end)

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100 
    SetTextScale(0.35, 0.35)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextColour(255, 255, 255, 215)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()   
end

function Animationteslimat()
    Citizen.CreateThread(function()
        while impacts < 1 do
            Citizen.Wait(1)
		local ped = PlayerPedId()	
                RequestAnimDict("random@train_tracks")
                FreezeEntityPosition(ped, true)
                TaskPlayAnim((ped), 'random@train_tracks', 'idle_e', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
                exports['sway_taskbar']:taskBar(10500, "Teslimat yapılıyor...") -- Teslimat yapılırken aşağıda çıkan bar saniyesi ve yazısı
                SetEntityHeading(ped, 270.0)
                ClearPedTasks(ped)
                impacts = impacts+1
                if impacts == 1 then 
                    FreezeEntityPosition(ped, false)
                    CaTeslimat = false
                    impacts = 0
                    Citizen.Wait(15)
                    TriggerServerEvent("ca:pcteslimat")
                    break
                end        
        end
    end)
end

RegisterNetEvent("btc:view")
AddEventHandler("btc:view", function()
  ESX.UI.Menu.CloseAll()

  if scratchbtcIsAWinner() then
    reward = determineWinningAmount()
    dispenseReward(reward)
    showWonNotification(reward)
  else
    TriggerServerEvent('btc:dispenseUsedScratchbtc')
    Citizen.Wait(15)
    showLostNotification()
  end

end)

function scratchbtcIsAWinner()
  math.randomseed(GetGameTimer())
  return (math.random(1, Config.OneInChanceOfWinning) == 1)
end

function determineWinningAmount()
  math.randomseed(GetGameTimer())
  return math.random(Config.WinningAmountMinimum, Config.WinningAmountMaximum)
end

function dispenseReward(amount)
  TriggerServerEvent('btc:dispenseReward', amount)
  Citizen.Wait(15)
end

function showWonNotification(amount)
  ESX.ShowNotification("BTC kağıdında yükselen kurda kazandın, tebrikler KAZANÇ: $" .. amount .. "!")
  Citizen.Wait(15)
end

function showLostNotification()
  ESX.ShowNotification("BTC kağıdında azalan kurda kaybettin bir dahakine bol şans!")
  Citizen.Wait(15)
end

function FinishedMining()
	local streetName, crossing = GetStreetNameAtCoord(x, y, z)
	streetName = GetStreetNameFromHashKey(streetName)
	crossing = GetStreetNameFromHashKey(crossing)
				local coords      = GetEntityCoords(GetPlayerPed(-1))
                Citizen.Wait(15)
				print('Polise Bildirim Gitti.')
		TriggerServerEvent('esx_phone:send', "police", "Siber bilişim: Kötü yazılım programları devreye sokuldu. Konum:"
		 , true, {
			x = coords.x,
			y = coords.y,
			z = coords.z
		})
    end