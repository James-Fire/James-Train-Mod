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