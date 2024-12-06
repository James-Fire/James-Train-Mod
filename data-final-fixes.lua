if settings.startup["weighty-trains"].value then
	for i, rollingstock in pairs(data.raw.locomotive) do
		rollingstock.weight = rollingstock.weight*settings.startup["weighty-trains-factor"].value
	end
	for i, rollingstock in pairs(data.raw["cargo-wagon"]) do
		rollingstock.weight = rollingstock.weight*settings.startup["weighty-trains-factor"].value
	end
	for i, rollingstock in pairs(data.raw["fluid-wagon"]) do
		rollingstock.weight = rollingstock.weight*settings.startup["weighty-trains-factor"].value
	end
	for i, rollingstock in pairs(data.raw["artillery-wagon"]) do
		rollingstock.weight = rollingstock.weight*settings.startup["weighty-trains-factor"].value
	end
end

for i, rollingstock in pairs(data.raw["item-with-entity-data"]) do
	if rollingstock.place_result then
		if rollingstock.place_result:find("locomotive", 1, true) or rollingstock.place_result:find("train", 1, true) then
			rollingstock.subgroup = "locomotives"
		elseif rollingstock.place_result:find("wagon", 1, true) then
			rollingstock.subgroup = "wagons"
		end
	end
end

if settings.startup["powered-rails"].value then
	if not (mods["FluidicPower"]) and settings.startup["powered-rails-adjacent"].value then
		data.raw["electric-pole"]["james-track-pole"].supply_area_distance = 2
	end
	local Rails = {
		"straight-rail",
		"half-diagonal-rail",
		"curved-rail-a",
		"curved-rail-b",
	}
	if(mods["elevated-rails"]) then
		table.insert(Rails, "elevated-straight-rail")
		table.insert(Rails, "elevated-half-diagonal-rail")
		table.insert(Rails, "elevated-curved-rail-a")
		table.insert(Rails, "elevated-curved-rail-b")
	end
	
	for i, rail in pairs(Rails) do
		local RailEntity = data.raw[rail][rail]
		local PoweredRailEntity = data.raw[rail]["james-powered-rail-"..rail]
		if RailEntity.fast_replaceable_group == nil then
			RailEntity.fast_replaceable_group = rail
		end
		PoweredRailEntity.fast_replaceable_group = RailEntity.fast_replaceable_group
	end
	if(mods["elevated-rails"]) then
		local RailEntity = data.raw["rail-ramp"]["rail-ramp"]
		local PoweredRailEntity = data.raw["rail-ramp"]["james-powered-rail-ramp"]
		if RailEntity.fast_replaceable_group == nil then
			RailEntity.fast_replaceable_group = "rail-ramp"
		end
		PoweredRailEntity.fast_replaceable_group = RailEntity.fast_replaceable_group
	end
end