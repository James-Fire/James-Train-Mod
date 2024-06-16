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
	if rollingstock.place_result:find("locomotive", 1, true) or rollingstock.place_result:find("train", 1, true) then
		rollingstock.subgroup = "locomotives"
	elseif rollingstock.place_result:find("wagon", 1, true) then
		rollingstock.subgroup = "wagons"
	end
end

if settings.startup["powered-rails"].value then
	if not (mods["FluidicPower"]) and settings.startup["powered-rails-adjacent"].value then
		data.raw["electric-pole"]["james-track-pole"].supply_area_distance = 2
	end
	
	data.raw["curved-rail"]["james-powered-rail-curved"].fast_replaceable_group = data.raw["curved-rail"]["curved-rail"].fast_replaceable_group
	data.raw["straight-rail"]["james-powered-rail"].fast_replaceable_group = data.raw["straight-rail"]["straight-rail"].fast_replaceable_group
end