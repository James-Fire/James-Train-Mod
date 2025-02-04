function CheckTableValue(Value,Table)
	for i, v in pairs(Table) do
		if Value == v then
			return true
		end
	end
	return false
end

function areaAroundPosition(position, extraRange)
	if type(extraRange) ~= "number" then extraRange = 0 end
	return {
		{x = math.floor(position.x) - extraRange,     y = math.floor(position.y) - extraRange},
		{x = math.floor(position.x) + 1 + extraRange, y = math.floor(position.y) + 1 + extraRange}
	}
end

function GetTrainLocomotives(Train)
	local Locomotives = { }
	for i, locomotive in pairs(Train.locomotives.front_movers) do
		table.insert(Locomotives, locomotive)
	end
	for i, locomotive in pairs(Train.locomotives.back_movers) do
		table.insert(Locomotives, locomotive)
	end
	return Locomotives
end

function GetTrainWagons(Train)
	local Wagons = { }
	for i, wagon in pairs(Train.cargo_wagons) do
		table.insert(Wagons, wagon)
	end
	for i, wagon in pairs(Train.fluid_wagons) do
		table.insert(Wagons, wagon)
	end
	return Wagons
end

function LocomotiveIsElectric(Locomotive)
	if Locomotive.name:find("ret-", 1, true) then
		return true
	elseif Locomotive.name:find("hybrid", 1, true) then
		return true
	elseif Locomotive.name:find("electric", 1, true) then
		return true
	end
	return false
end

function WagonIsElectric(Wagon)
	--game.print("checking wagon")
	if Wagon.name:find("wagon-electric", 1, true) then
		--game.print("wagon is electric")
		return true
	end
	return false
end

function TrainIsElectric(Train)
	for i, Locomotive in pairs(GetTrainLocomotives(Train)) do
		if LocomotiveIsElectric(Locomotive) then
			return true
		end
	end
	return false
end

function TrainIsNotElectric(Train)
	--game.print("train is train")
	for i, Locomotive in pairs(GetTrainLocomotives(Train)) do
		if LocomotiveIsElectric(Locomotive) then
			--game.print("train is electric")
			return false
		end
	end
	--game.print("train is not electric")
	return true
end

function TrainHasElectricWagon(Train)
	for i, Wagon in pairs(GetTrainWagons(Train)) do
		if WagonIsElectric(Wagon) then
			return true
		end
	end
	return false
end

function GetConnectedRails(Rail)
	local RailTable = {}
	for i, direction in pairs(defines.rail_direction) do
		if direction then
			for j, connection in pairs(defines.rail_connection_direction) do
				if j == "none" then  
				else
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

function DisconnectAllWires(PoleEntity)
	if PoleEntity.valid then
		for i, Wires in pairs(PoleEntity.get_wire_connectors(true)) do
			Wires.disconnect_all()
		end
	end
end

function ConnectAllWires(PoleEntitySource, PoleEntityTarget)
	if PoleEntitySource.valid and PoleEntityTarget.valid then
		--local SourceCopper = PoleEntitySource.get_wire_connector(7,true)
		--local SourceRed = PoleEntitySource.get_wire_connector(1,true)
		--local SourceGreen = PoleEntitySource.get_wire_connector(2,true)
		local TargetCopper = PoleEntityTarget.get_wire_connector(5,true)
		local TargetRed = PoleEntityTarget.get_wire_connector(1,true)
		local TargetGreen = PoleEntityTarget.get_wire_connector(2,true)
		PoleEntitySource.get_wire_connector(5,true).connect_to(TargetCopper,false)
		PoleEntitySource.get_wire_connector(1,true).connect_to(TargetRed,false)
		PoleEntitySource.get_wire_connector(2,true).connect_to(TargetGreen,false)
	end
end