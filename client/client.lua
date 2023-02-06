lib.locale()

local Washing = false
local InWashRoom = false
local Cooldown =  false

local function StartCooldown()
	Washing = false
	Citizen.SetTimeout(Config.Moneywash.Cooldown, function()
		Cooldown = false
		lib.notify({title = locale('title'),description = locale('cooldown_ended'),type = 'inform'})
	end)
end

local function StartWash()
	if Washing == true then lib.notify({title = locale('title'),description = locale('already_washing'),type = 'error'}) end

	if not Cooldown then
		local input = lib.inputDialog(locale('menu_title'), {locale('menu_desc')})

		if not input then return end
		local WashAmount = tonumber(input[1])
		TriggerServerEvent('stevo_moneywash:server:EndOfWask', WashAmount)

		Washing = true
		Cooldown = true

		lib.notify({title = locale('title'),description = locale('started_washing'),type = 'inform'})

		if lib.progressCircle({
			duration = Config.Moneywash.WashDuration,
			position = 'bottom',
			useWhileDead = false,
			canCancel = true,
		}) then lib.notify({title = locale('title'), description = locale('finished_washing'), type = 'inform'}) end
		StartCooldown()
	else
		lib.notify({title = locale('title'),description = locale('cooldown_active'),type = 'error'})
	end
end

local function EnterLaundry()
	local EntranceCheck = exports.ox_inventory:Search('count', Config.EntranceTicket)
	if EntranceCheck >= 1 then
		if InWashRoom == false then
			InWashRoom = true
			SetEntityCoords(PlayerPedId(), Config.Moneywash.Enter)
		end
	end
end

local function ExitLaundry()
	if Washing == true then lib.notify({title = locale('title'),description = locale('cannot_exit'),type = 'error'}) end

	if Washing == false then
		InWashRoom = false
		SetEntityCoords(PlayerPedId(), Config.Moneywash.Exit)
	end
end

	exports.ox_target:addSphereZone({
		coords = Config.Zones.WashZone,
		radius = 2,
		debug = drawZones,
		distance = 1,
		options = {
			{
				name = 'Wash',
				onSelect = function ()
					StartWash()
				end,
				icon = 'fa-solid fa-money-bill',
				label = locale('start_laundry'),
				canInteract = function()
					return InWashRoom
				end
			}
		}
	})
	
	
	exports.ox_target:addSphereZone({
		coords = Config.Zones.ExitZone,
		radius = 2,
		debug = drawZones,
		distance = 1,
		options = {
			{
				name = 'Exit',
				onSelect = function ()
					ExitLaundry()
				end,
				icon = 'fa-solid fa-door-open',
				label = locale('exit_laundry'),
				canInteract = function()
					return InWashRoom and not Washing
				end
			}
		}
	})
	
	exports.ox_target:addSphereZone({
		coords = Config.Zones.EntryZone,
		radius = 1,
		debug = drawZones,
		distance = 1,
		options = {
			{
				name = 'Entry',
				onSelect = function ()
					EnterLaundry()
				end,
				icon = 'fa-solid fa-door-open',
				label = locale('enter_laundry'),
				canInteract = function()
					return not Cooldown
				end
			}
		}
	})





