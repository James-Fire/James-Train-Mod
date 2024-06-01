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
	data.raw["accumulator"]["james-rail-accumulator"].next_upgrade = nil
end