for i, v in pairs({2,3}) do
	local locomotive_entity = table.deepcopy(data.raw.locomotive["locomotive"])
	locomotive_entity.name = "locomotive-"..tostring(v)
	--weight = 1000,
    --max_speed = 1.5,
    --braking_force = 3,
	--max_power = "600kW",
    reversing_power_modifier = 0.6,
	local locomotive_item = table.deepcopy(data.raw.["item-with-entity-data"]["locomotive"])
	locomotive_item.name = "locomotive-"..tostring(v)

	LSlib.recipe.duplicate("locomotive", "locomotive-"..tostring(v))
end