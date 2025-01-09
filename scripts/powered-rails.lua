require("scripts/common-functions")

local FakeBurnerItem = "electric-burner-item"
local AccumName = "james-rail-accumulator"
local HiddenPoleName = "james-track-pole"
local SignalPoleName = "james-rail-pole"
local UpdateTime = 60 --Ticks, 60/s
local WagonPowerUse = 400000 --How much power each electric wagon uses in UpdateTime. J

--Initialization Function
local function OnInit()
	storage.JamesElectricTrains = { }
	storage.JamesElectricWagonTrains = { }
	storage.JamesRegenBrakingTrains = { }
	storage.JETrainsUpdate = { }
	storage.JECounter = 0
end
script.on_init(OnInit)

local function ConfigChanged()
	if not storage.JamesElectricTrains then
		storage.JamesElectricTrains = { }
	end
	if not storage.JamesElectricWagonTrains then
		storage.JamesElectricWagonTrains = { }
	end
	if not storage.JamesElectricWagonTrains then
		storage.JamesElectricWagonTrains = { }
	end
	if not storage.JamesRegenBrakingTrains then
		storage.JamesRegenBrakingTrains = { }
	end
	if not storage.JETrainsUpdate then
		storage.JETrainsUpdate = { }
	end
	if not storage.JECounter then
		storage.JECounter = 0
	end
end

script.on_configuration_changed(ConfigChanged)

local function TrainIsBraking(Train)
	--game.print(Train.riding_state.acceleration)
	if Train and Train.valid and Train.riding_state.acceleration == 2 --[[(Train.state == on_the_path or Train.state == arrive_signal or Train.state == arrive_station or Train.state == manual_control_stop)]] then
		return true
	end
	return false
end

--Arbiter function for if we should handle a train in the moment, is passed a locomotive
--[[local function LocomotiveIsElectricNow(Locomotive)
	if LocomotiveIsElectric(Locomotive) then
		local LocoBurner = Locomotive.burner or Locomotive.energy_source
		if LocoBurner and LocoBurner.currently_burning == nil then --The train is handled if it's burning nothing
			return true
		elseif LocoBurner.currently_burning.name.name == FakeBurnerItem then --The train is handled if it's already burning our dummy item
			return true
		else
			return false
		end
	end
end]]


local function GetHiddenPole(surface, position)
	return surface.find_entity(HiddenPoleName, position)
end

--Takes a rail, makes and connects sub-poles
local function SetupCableConnections(entity)
	local HostPole = GetHiddenPole(entity.surface, entity.position)
	if HostPole and HostPole.valid then
		for i, neighbour in pairs(GetConnectedRails(entity)) do
			local NeighbourPole = GetHiddenPole(neighbour.surface, neighbour.position)
			if NeighbourPole and NeighbourPole.valid then
				ConnectAllWires(HostPole, NeighbourPole)
			end
		end
	end
end

local function MakeSignalPole(entity)
	local surface = entity.surface
	if surface and surface.valid then
		surface.create_entity({name = SignalPoleName, position = entity.position, force = entity.force, raise_built = false})
		local SignalPole = surface.find_entity(SignalPoleName, entity.position)
		DisconnectAllWires(SignalPole)
		for i, rail in pairs (entity.get_connected_rails()) do
			local RailHiddenPole = surface.find_entity(HiddenPoleName, rail.position)
			if RailHiddenPole then
				ConnectAllWires(SignalPole, RailHiddenPole)
			end
		end
		entity.destroy()
	end
end

local function MakeHiddenPole(entity)
	local surface = entity.surface
	if surface and surface.valid then
		surface.create_entity({name = HiddenPoleName, position = entity.position, force = entity.force, raise_built = false})
		local hiddenPole = surface.find_entity(HiddenPoleName, entity.position)
		if hiddenPole then
			DisconnectAllWires(hiddenPole)
		end
	end
end

local function MakeHiddenAccum(surface, position, force)
	if surface and surface.valid then
		surface.create_entity({name = AccumName, position = position, force = force, raise_built = false})
	end
end
local function removeHiddenPowerEntities(surface, position)
	if surface and surface.valid then
		--game.print("Surface Valid for pole removal")
		for i, accumulator in pairs(surface.find_entities_filtered{name = AccumName, position = position}) do
			--game.print(serpent.block(accumulator))
			accumulator.destroy()
		end
		for i, pole in pairs(surface.find_entities_filtered{name = HiddenPoleName, position = position}) do
			--game.print(serpent.block(pole))
			DisconnectAllWires(pole)
			pole.destroy()
		end
	end
end

local function on_new_train(event)
	local NewTrain = event.train
	if not NewTrain then return end
	if TrainIsElectric(NewTrain) and CheckTableValue(NewTrain,storage.JamesElectricTrains) == false then
		table.insert(storage.JamesElectricTrains, NewTrain)
	end
	if TrainHasElectricWagon(NewTrain) and CheckTableValue(NewTrain,storage.JamesElectricWagonTrains) == false then
		table.insert(storage.JamesElectricWagonTrains, NewTrain)
	end
end
local function RemoveEntityError(entity, player)
	local entity_surface = entity.surface
	local entity_force = entity.force
	local entity_position = entity.position
	local wagon = entity.prototype.items_to_place_this[1].name
	--game.print(wagon)
	
	entity_position.y = entity_position.y - 2 --+ math.random()
	-- entity_position.x = entity_position.x - 1 + math.random()
	entity.destroy()
	if player then
		local playerinv = game.connected_players[player].get_main_inventory()
		playerinv.insert({name=wagon, count=1})
	else
		entity_surface.spill_item_stack{position = entity_position, stack = {name=wagon, count=1}, force = entity_force}
	end
	for _,player in pairs(game.connected_players) do
		local pid = player.index
		local player_force = player.force.name

		local render_data = {
			target = {offset = {x=0,y=-2}},
			scale = 1,
			time_to_live = 120,
			players = {player},
			alignment = "center",
		}
		render_data.text = "You can't use Electric Wagons on non-electric trains"
		render_data.surface = entity_surface
		--render_data.target.entity = entity
		render_data.target = entity_position
		render_data.color = {r=200,g=0,b=0}

		rendering.draw_text(render_data)
	end
end

local function on_new_entity(event)
	local entity = event.created_entity or event.entity --Handle multiple event types
	if not entity then return end
	local surface = entity.surface
	local position = entity.position
	local force = entity.force
	local player = event.player_index
	--game.print(entity.name)
	--game.print(tostring(WagonIsElectric(entity)))
	--game.print(tostring(TrainIsNotElectric(entity.train)))
	if WagonIsElectric(entity) and TrainIsNotElectric(entity.train) then
		--game.print("Wagon is Electric, train not")
		RemoveEntityError(entity, player)
	elseif entity.name:find("james-powered-rail", 1, true) or entity.name:find("-rail-electric", 1, true) then
		MakeHiddenAccum(surface, position, entity.force)
		MakeHiddenPole(entity)
		SetupCableConnections(entity)
	elseif LocomotiveIsElectric(entity) and entity.train and CheckTableValue(entity.train,storage.JamesElectricTrains) == false then
		table.insert(storage.JamesElectricTrains, entity.train)
	elseif entity.name == "james-rail-signal" then
		MakeSignalPole(entity)
	end
end
local function on_remove_entity(event)
	local entity = event.created_entity or event.entity --Handle multiple event types
	if not entity then return end
	local surface = entity.surface
	local position = entity.position
	if entity.name:find("james-powered-rail", 1, true) then
		removeHiddenPowerEntities(surface, position)
	end
end

--Every so often go through our train list to power them
local function PowerTrain(Train)
	local PowerNeeded = 0 --Single Value of power required by the whole train
	local Accumulators = { } --Array of all accumulators available to this train
	local AvailablePower = 0
	local LocomotiveCount = 0
	
	
	for i, locomotive in pairs(GetTrainLocomotives(Train)) do
		--game.print("Current Power: "..tostring(locomotive.burner.remaining_burning_fuel))
		if LocomotiveIsElectric(locomotive) then
			if locomotive.burner.currently_burning then
				--game.print("Loco Currently Burning: "..tostring(locomotive.energy_source.currently_burning.name.name))
				--game.print("Fuel Value: "..tostring(locomotive.burner.currently_burning.name.fuel_value))
				PowerNeeded = PowerNeeded + locomotive.burner.currently_burning.name.fuel_value*0.6 - locomotive.burner.remaining_burning_fuel
			else
				--game.print("Loco is not burning, using default transfer value")
				PowerNeeded = PowerNeeded + 60000000
			end
			LocomotiveCount = LocomotiveCount + 1
		else
			--game.print("Loco "..locomotive.name.." is not electric, not handling")
			--game.print("Loco Currently Burning: "..tostring(locomotive.burner.currently_burning.name.name))
		end
	end
	if PowerNeeded <= 0 then
		return
	end
	--game.print("Desired Power: "..tostring(PowerNeeded))
	for i, rail in pairs(Train.get_rails()) do
		local surface = rail.surface
		local Accumulator = surface.find_entity(AccumName, rail.position)
		if Accumulator and Accumulator.valid then
			--game.print("Accumulator Energy: "..tostring(Accumulator.energy))
			AvailablePower = AvailablePower + Accumulator.energy
			table.insert(Accumulators, Accumulator)
		end
	end
	--game.print("Available Power: "..tostring(AvailablePower))
	--game.print("Available Accumulators: "..tostring(#Accumulators))
	local PowerTransfer = 0
	if PowerNeeded > AvailablePower then
		PowerTransfer = AvailablePower
	else
		PowerTransfer = PowerNeeded
	end
	--game.print("Power Transfer: "..tostring(PowerTransfer))
	local AccumulatorDraw = PowerTransfer/#Accumulators
	local LocoPowerTransfer = PowerTransfer/(#Train.locomotives.front_movers+#Train.locomotives.back_movers)
	for i, Accumulator in pairs(Accumulators) do
		Accumulator.energy = Accumulator.energy - AccumulatorDraw
	end
	for i, locomotive in pairs(GetTrainLocomotives(Train)) do
		if LocomotiveIsElectric(locomotive) then
			locomotive.burner.currently_burning = FakeBurnerItem
			locomotive.burner.remaining_burning_fuel = locomotive.burner.remaining_burning_fuel + LocoPowerTransfer
		end
	end
	
	if PowerTransfer < 1 then --If the train didn't get a lot of power, make it get updated again soon
		table.insert(storage.JETrainsUpdate, 1, train)
	end
end

local function train_regenerative_braking(Train)
	if Train and Train.valid and TrainIsBraking(Train) then
		--game.print("Train is braking")
		local LocomotiveCount = 0
		local WagonCount = 0
		for i, wagon in pairs(GetTrainWagons(Train)) do
			if WagonIsElectric(wagon) then
				WagonCount = WagonCount + 1
			end
		end
		local RegenTransfer = WagonCount * WagonPowerUse * 0.4
		for i, Locomotive in pairs(GetTrainLocomotives(Train)) do
			if LocomotiveIsElectric(Locomotive) then
				LocomotiveCount = LocomotiveCount + (Locomotive.prototype.get_max_energy_usage() * 0.4)
			end
		end
		local RegenTransfer = RegenTransfer + LocomotiveCount
		
		for i, locomotive in pairs(GetTrainLocomotives(Train)) do
			if LocomotiveIsElectric(locomotive) then
				locomotive.burner.remaining_burning_fuel = locomotive.burner.remaining_burning_fuel + RegenTransfer
			end
		end
	else
		table.remove(storage.JamesRegenBrakingTrains, Train)
	end
end

local function train_state_handler(event)
	local Train = event.train
	if Train and Train.valid and TrainIsBraking(Train) and TrainIsElectric(Train) then
		table.insert(storage.JamesRegenBrakingTrains, Train)
	end
end

local function WagonPower(Train)
	local LocomotiveCount = #GetTrainLocomotives(Train)
	local WagonCount = 0
	for i, wagon in pairs(GetTrainWagons(Train)) do
		if wagon and wagon.valid and WagonIsElectric(wagon) then
			local ThisWagon = 0
			if wagon.name:find("-1", 1, true) then
				ThisWagon = ThisWagon + 1
			end
			if wagon.name:find("-2", 1, true) then
				ThisWagon = ThisWagon + 2
			end
			if wagon.name:find("-3", 1, true) then
				ThisWagon = ThisWagon + 3
			end
			if wagon.name:find("artillery", 1, true) then
				ThisWagon = ThisWagon * 4
			end
			WagonCount = WagonCount + ThisWagon
		end
	end
	local WagonDrain = WagonCount * WagonPowerUse / LocomotiveCount
	for i, locomotive in pairs(GetTrainLocomotives(Train)) do
		if locomotive and locomotive.valid and LocomotiveIsElectric(locomotive) then
			locomotive.burner.remaining_burning_fuel = locomotive.burner.remaining_burning_fuel - WagonDrain
		end
	end
end

local function PrintStorageTrainList()
	game.print("Printing out current list of electric trains")
	for i, entry in pairs(storage.JamesElectricTrains) do
		game.print("Train "..tostring(i)..": "..serpent.block(entry))
	end
end
local function PrintUpdateTrainList()
	game.print("Printing out queued update list of electric trains")
	for i, entry in pairs(storage.JETrainsUpdate) do
		game.print("Train "..tostring(i)..": "..serpent.block(entry))
	end
end

local function RemakeTrainUpdateList()
	--PrintstorageTrainList()
	--game.print("Make Train Update List")
	if storage.JamesElectricTrains then
		for i, train in pairs(storage.JamesElectricTrains) do
			table.insert(storage.JETrainsUpdate, train)
		end
	else
		game.print("No storages, save broken?")
	end
end

commands.add_command("RemakeTrainUpdateList", "", RemakeTrainUpdateList)
commands.add_command("PrintstorageTrainList", "", PrintStorageTrainList)
commands.add_command("PrintUpdateTrainList", "", PrintUpdateTrainList)

local function UpdateTrains()
	--PrintUpdateTrainList()
	local NilRegenBrakingTrains = { }
	for i, train in pairs(storage.JamesRegenBrakingTrains) do
		if train and train.valid and TrainIsBraking(train) then
			train_regenerative_braking(train)
		else
			table.insert(NilRegenBrakingTrains, i)
		end
	end
	for i, entry in pairs(NilRegenBrakingTrains) do
		table.remove(storage.JamesRegenBrakingTrains, entry)
	end
	storage.JECounter = storage.JECounter + 1
	if storage.JECounter >= UpdateTime then
		storage.JECounter = 0
		--game.print("tick")
		for i, train in pairs(storage.JamesElectricWagonTrains) do
			if train and train.valid and train.state == 0 then
				WagonPower(train)
			end
		end
		
		for i = 1,#storage.JamesElectricTrains,1 do
			--if i == settings.storage["train-update-count"].value then
			--	break
			--end
			if storage.JETrainsUpdate[1] ~= nil and storage.JETrainsUpdate[1].valid then
				--game.print("Update train in update list")
				PowerTrain(table.remove(storage.JETrainsUpdate, 1))
			else
				table.remove(storage.JETrainsUpdate, 1)
				--game.print("First entry isn't valid")
			end
			if #storage.JETrainsUpdate == 0 then
				--game.print("Update list is empty, remaking")
				RemakeTrainUpdateList()
			end
		end
	end
end

script.on_event(defines.events.on_tick, function(event)
	--game.print("pre tick")
	--game.print(tostring(storage.JECounter))
	UpdateTrains()
end)

script.on_event(defines.events.on_train_created, on_new_train)
script.on_event(defines.events.on_train_changed_state, train_state_handler)
script.on_event(defines.events.on_entity_died, on_remove_entity)
script.on_event(defines.events.on_robot_mined_entity, on_remove_entity)
script.on_event(defines.events.on_player_mined_entity, on_remove_entity)
script.on_event(defines.events.script_raised_destroy, on_remove_entity)
script.on_event(defines.events.on_built_entity, on_new_entity)
script.on_event(defines.events.on_robot_built_entity, on_new_entity)
script.on_event(defines.events.script_raised_built, on_new_entity)
script.on_event(defines.events.script_raised_revive, on_new_entity)