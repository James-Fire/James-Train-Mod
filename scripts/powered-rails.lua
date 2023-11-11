local FakeBurnerItem = "electric-burner-item"
local AccumName = "james-rail-accumulator"
local HiddenPoleName = "james-track-pole"
local SignalPoleName = "james-rail-pole"
local UpdateTime = 160 --Ticks, 16/s
local WagonPowerUse = 1000000 --How much power each electric wagon uses in UpdateTime. J

local function CheckTableValue(Value,Table)
	for i, v in pairs(Table) do
		if Value == v then
			return true
		end
	end
	return false
end

--Initialization Function
local function OnInit()
	global.JamesElectricTrains = { }
	global.JamesElectricWagonTrains = { }
	global.JETrainsUpdate = { }
	global.JECounter = 0
end

local function GetTrainLocomotives(Train)
	local Locomotives = { }
	for i, locomotive in pairs(Train.locomotives.front_movers) do
		table.insert(Locomotives, locomotive)
	end
	for i, locomotive in pairs(Train.locomotives.back_movers) do
		table.insert(Locomotives, locomotive)
	end
	return Locomotives
end
local function GetTrainWagons(Train)
	local Wagons = { }
	for i, wagon in pairs(Train.cargo_wagons) do
		table.insert(Wagons, wagon)
	end
	for i, wagon in pairs(Train.fluid_wagons) do
		table.insert(Wagons, wagon)
	end
	return Wagons
end

--Arbiter function for if we should *ever* handle a train, is passed a locomotive
local function ValidLocomotive(Locomotive)
	if Locomotive.name:find("ret", 1, true) then
		return true
	elseif Locomotive.name:find("hybrid", 1, true) then
		return true
	elseif Locomotive.name:find("electric", 1, true) then
		return true
	end
	return false
end

local function WagonIsElectric(Wagon)
	if Wagon.name:find("wagon-electric", 1, true) then
		return true
	end
	return false
end

local function TrainHasValidLocomotive(Train)
	for i, Locomotive in pairs(GetTrainLocomotives(Train)) do
		if ValidLocomotive(Locomotive) then
			return true
		end
	end
	return false
end

local function TrainHasElectricWagon(Train)
	for i, Wagon in pairs(GetTrainWagons(Train)) do
		if WagonIsElectric(Wagon) then
			return true
		end
	end
	return false
end

--Arbiter function for if we should handle a train in the moment, is passed a locomotive
local function LocomotiveIsElectricNow(Locomotive)
	if Locomotive.burner.currently_burning == nil then --The train is handled if it's burning nothing
		return true
	elseif Locomotive.burner.currently_burning.name == FakeBurnerItem then --The train is handled if it's already burning our dummy item
		return true
	else
		return false
	end
end

--When powered rails are built/removed

--Collects all connected rails into a table
local function GetConnectedRails(Rail)
	local RailTable = {}
	for i, direction in pairs(defines.rail_direction) do
		if direction then
			for j, connection in pairs(defines.rail_connection_direction) do
				if j == "none" then  
				else
					--log(tostring(connection))
					local ConnectedRail, dir, cdir = Rail.get_connected_rail({ rail_direction = direction, rail_connection_direction = connection })
					if ConnectedRail and ConnectedRail.valid then
						table.insert(RailTable, ConnectedRail)
					end
				end
			end
		end
	end
	return RailTable
end

local function GetHiddenPole(surface, position)
	return surface.find_entity(HiddenPoleName, position)
end

--Takes a rail, makes and connects sub-poles
local function SetupCableConnections(entity)
	local HostPole = GetHiddenPole(entity.surface, entity.position)
	if HostPole and HostPole.valid then
		for i, neighbour in pairs(GetConnectedRails(entity)) do
			local NeighbourPole = GetHiddenPole(neighbour.surface, neighbour.position)
			for j, v in pairs(defines.wire_type) do
				NeighbourPole.connect_neighbour({wire = v , target_entity = HostPole})
			end
		end
	end
end

local function MakeSignalPole(entity)
	local surface = entity.surface
	if surface and surface.valid then
		surface.create_entity({name = SignalPoleName, position = entity.position, force = entity.force, raise_built = false})
		local SignalPole = surface.find_entity(SignalPoleName, entity.position)
		SignalPole.disconnect_neighbour()
		for i, rail in pairs (entity.get_connected_rails()) do
			local RailHiddenPole = surface.find_entity(HiddenPoleName, rail.position)
			RailHiddenPole.connect_neighbour(SignalPole)
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
			hiddenPole.disconnect_neighbour()
		end
	end
end

local function MakeHiddenAccum(surface, position)
	if surface and surface.valid then
		surface.create_entity({name = AccumName, position = position, raise_built = false})
	end
end
local function removeHiddenPowerEntities(surface, position)
	if surface and surface.valid then
		for i, accumulator in pairs(surface.find_entities_filtered{name = AccumName, position = position}) do
			accumulator.destroy()
		end
		for i, pole in pairs(surface.find_entities_filtered{name = HiddenPoleName, position = position}) do
			pole.destroy()
		end
	end
end

local function on_new_train(event)
	local NewTrain = event.train
	if not NewTrain then return end
	if TrainHasValidLocomotive(NewTrain) and CheckTableValue(NewTrain,global.JamesElectricTrains) == false then
		table.insert(global.JamesElectricTrains, NewTrain)
	end
	if TrainHasElectricWagon(NewTrain) and CheckTableValue(NewTrain,global.JamesElectricWagonTrains) == false then
		table.insert(global.JamesElectricWagonTrains, NewTrain)
	end
end
local function on_new_entity(event)
	local entity = event.created_entity or event.entity --Handle multiple event types
	if not entity then return end
	local surface = entity.surface
	local position = entity.position
	local force = entity.force
	if entity.name == "james-powered-rail" or entity.name == "james-powered-rail-curved" then
		MakeHiddenAccum(surface, position)
		MakeHiddenPole(entity)
		SetupCableConnections(entity)
	elseif ValidLocomotive(entity) and entity.train and CheckTableValue(entity.train,global.JamesElectricTrains) == false then
		table.insert(global.JamesElectricTrains, entity.train)
	--[[elseif WagonIsElectric and entity.train and CheckTableValue(entity.train,global.JamesElectricTrains) == false then
		table.insert(global.JamesElectricTrains, entity.train)]]
	elseif entity.name == "james-rail-signal" then
		MakeSignalPole(entity)
	end
end
local function on_remove_entity(event)
	local entity = event.created_entity or event.entity --Handle multiple event types
	if not entity then return end
	local surface = entity.surface
	local position = entity.position
	local force = entity.force
	if entity.name == "james-powered-rail" or entity.name == "james-powered-rail-curved" then
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
		if LocomotiveIsElectricNow(locomotive) then
			if locomotive.burner.currently_burning then
				--game.print("Loco Currently Burning: "..tostring(locomotive.burner.currently_burning.name))
				PowerNeeded = PowerNeeded + locomotive.burner.currently_burning.fuel_value - locomotive.burner.remaining_burning_fuel
			else
				--game.print("Loco is not burning, using default transfer value")
				PowerNeeded = PowerNeeded + 100000000
			end
			LocomotiveCount = LocomotiveCount + 1
		else
			--game.print("Loco is not electric, not handling")
			--game.print("Loco Currently Burning: "..tostring(locomotive.burner.currently_burning.name))
		end
	end
	--game.print("Desired Power: "..tostring(PowerNeeded))
	for i, rail in pairs(Train.get_rails()) do
		local surface = rail.surface
		local Accumulator = surface.find_entity(AccumName, rail.position)
		AvailablePower = AvailablePower + Accumulator.energy
		table.insert(Accumulators, Accumulator)
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
		if LocomotiveIsElectricNow(locomotive) then
			locomotive.burner.currently_burning = FakeBurnerItem
			locomotive.burner.remaining_burning_fuel = locomotive.burner.remaining_burning_fuel + LocoPowerTransfer
		end
	end
	
	if PowerTransfer < 1 then --If the train didn't get a lot of power, make it get updated again soon
		table.insert(global.JETrainsUpdate, 1, train)
	end
end

local function WagonPower(Train)
	local LocomotiveCount = #GetTrainLocomotives(Train)
	local WagonCount = #GetTrainWagons(Train)
	local WagonDrain = WagonCount * WagonPowerUse / LocomotiveCount
	for i, locomotive in pairs(GetTrainLocomotives(Train)) do
		if LocomotiveIsElectricNow(locomotive) then
			locomotive.burner.remaining_burning_fuel = locomotive.burner.remaining_burning_fuel - WagonDrain
		end
	end
end

local function PrintGlobalTrainList()
	game.print("Printing out current list of electric trains")
	for i, entry in pairs(global.JamesElectricTrains) do
		game.print("Train "..tostring(i)..": "..serpent.block(entry))
	end
end
local function PrintUpdateTrainList()
	game.print("Printing out queued update list of electric trains")
	for i, entry in pairs(global.JETrainsUpdate) do
		game.print("Train "..tostring(i)..": "..serpent.block(entry))
	end
end

local function RemakeTrainUpdateList()
	--PrintGlobalTrainList()
	--game.print("Make Train Update List")
	for i, train in pairs(global.JamesElectricTrains) do
		table.insert(global.JETrainsUpdate, train)
	end
end

local function UpdateTrains()
	--PrintUpdateTrainList()
	for i, train in pairs(global.JamesElectricWagonTrains) do
		if train and train.valid and train.state == 0 then
			WagonPower(train)
		end
	end
	if global.JETrainsUpdate[1] ~= nil and global.JETrainsUpdate[1].valid  then
		--game.print("Update train in update list")
		PowerTrain(table.remove(global.JETrainsUpdate, 1))
	else
		table.remove(global.JETrainsUpdate, 1)
		--game.print("First entry isn't valid")
	end
	if #global.JETrainsUpdate == 0 then
		--game.print("Update list is empty, remaking")
		RemakeTrainUpdateList()
	end
end

script.on_event(defines.events.on_tick, function(event)
	--game.print("pre tick")
	global.JECounter = global.JECounter + 1
	if (global.JECounter == UpdateTime) then
		UpdateTrains()
		global.JECounter = 0
		--game.print("tick")
	end
end)

script.on_init(OnInit)
script.on_event(defines.events.on_train_created, on_new_train)
script.on_event(defines.events.on_entity_destroyed, on_remove_entity)
script.on_event(defines.events.on_entity_died, on_remove_entity)
script.on_event(defines.events.on_robot_mined_entity, on_remove_entity)
script.on_event(defines.events.on_player_mined_entity, on_remove_entity)
script.on_event(defines.events.on_built_entity, on_new_entity)
script.on_event(defines.events.on_robot_built_entity, on_new_entity)
script.on_event(defines.events.script_raised_built, on_new_entity)
script.on_event(defines.events.script_raised_revive, on_new_entity)