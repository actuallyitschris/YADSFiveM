--------------------------------
--- YET ANOTHER DEATH SCRIPT ---
--------- MADE BY CHRIS --------

-- Disable Autospawn

AddEventHandler('onClientMapStart', function()
	exports.spawnmanager:spawnPlayer()
	exports.spawnmanager:setAutoSpawn(false)
end)

-- Revive

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlPressed(1, 51) and IsPlayerDead(ped) then
        	revivePed()
        end
    end
end)

function revivePed(ped)
	local ped = GetPlayerPed(-1)
	local playerPos = GetEntityCoords(ped, true)

	NetworkResurrectLocalPlayer(playerPos, true, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)
end

-- Respawn
Citizen.CreateThread(function()
	local respawnCount = 0
	local spawnPoints = {}
	local playerIndex = NetworkGetPlayerIndex(-1) or 0


	math.randomseed(playerIndex)

	function createSpawnPoint(x1,x2,y1,y2,z,heading)
		local xValue = math.random(x1,x2) + 0.0001
		local yValue = math.random(y1,y2) + 0.0001

		local newObject = {
			x = xValue,
			y = yValue,
			z = z + 0.0001,
			heading = heading + 0.0001
		}
		table.insert(spawnPoints,newObject)
	end

	createSpawnPoint(-448, -448, -340, -329, 35.5, 0) -- Mount Zonah
	createSpawnPoint(372, 375, -596, -594, 30.0, 0)   -- Pillbox Hill
	createSpawnPoint(335, 340, -1400, -1390, 34.0, 0) -- Central Los Santos
	createSpawnPoint(1850, 1854, 3700, 3704, 35.0, 0) -- Sandy Shores
	createSpawnPoint(-247, -245, 6328, 6332, 33.5, 0) -- Paleto
	createSpawnPoint(1152, 1156, -1525, -1521, 34.9, 0) -- St. Fiacre

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlPressed(0, 45) and IsPlayerDead(ped) then
        local coords = spawnPoints[math.random(1,#spawnPoints)]
        	respawnPed(ped, coords)
        end
    end
end)

function respawnPed(ped, coords)
SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false)
TriggerEvent('playerSpawned', coords.x, coords.y, coords.z, coords.heading)
local ped = GetPlayerPed(-1)
  SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)
end

-- Dead

	while true do
		Wait(0)
		local ped = GetPlayerPed(-1)

			if (IsEntityDead(ped)) then
				SetPlayerInvincible(ped, true)
				SetEntityHealth(ped, 1)

          Info('You died! \nPress ~r~E~w~ to revive or ~r~R~w~ \nto respawn.')
			end
		end
end)

-- Info

function Info(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(text)
	DrawNotification(true, true)
end

--- YOU MAY MODIFY THE CODE ABOVE, ---
--- ALTHOUGH YOU MAY NOT REALESE IT ---
--- WITHOUT MY EXPLICIT PERMISSION ---
