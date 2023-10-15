for i, v in pairs({2,3}) do
	local locomotive_entity = table.deepcopy(data.raw.["cargo-wagon"].["cargo-wagon"])
	locomotive_entity.name = "cargo-wagon-"..tostring(v)
	--weight = 1000,
    --max_speed = 1.5,
    --braking_force = 3,
	local locomotive_item = table.deepcopy(data.raw.["item-with-entity-data"]["cargo-wagon"])
	locomotive_item.name = "cargo-wagon-"..tostring(v)

	LSlib.recipe.duplicate("cargo-wagon", "cargo-wagon-"..tostring(v))
end
