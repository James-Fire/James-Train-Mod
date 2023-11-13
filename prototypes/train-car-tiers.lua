
data.raw["cargo-wagon"]["cargo-wagon"].max_speed = 0.5
data.raw["fluid-wagon"]["fluid-wagon"].max_speed = 0.5
data.raw["artillery-wagon"]["artillery-wagon"].max_speed = 0.5

for i, v in pairs({2,3}) do
	local wagon_entity = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])
		wagon_entity.name = "cargo-wagon-"..tostring(v)
		--weight = 1000,
		--max_speed = 1.5,
		--braking_force = 3,
	local wagon_item = table.deepcopy(data.raw.["item-with-entity-data"]["cargo-wagon"])
		wagon_item.name = "cargo-wagon-"..tostring(v)

	LSlib.recipe.duplicate("cargo-wagon", "cargo-wagon-"..tostring(v))
end
