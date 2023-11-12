function CheckTableValue(Value,Table)
	for i, v in pairs(Table) do
		if Value == v then
			return true
		end
	end
	return false
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
	if Locomotive.name:find("ret", 1, true) then
		return true
	elseif Locomotive.name:find("hybrid", 1, true) then
		return true
	elseif Locomotive.name:find("electric", 1, true) then
		return true
	end
	return false
end

function WagonIsElectric(Wagon)
	if Wagon.name:find("wagon-electric", 1, true) then
		return true
	end
	return false
end

function TrainHasLocomotiveIsElectric(Train)
	for i, Locomotive in pairs(GetTrainLocomotives(Train)) do
		if LocomotiveIsElectric(Locomotive) then
			return true
		end
	end
	return false
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