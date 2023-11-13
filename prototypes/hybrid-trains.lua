local LocomotivePower = { "1MW", "2MW" }

local HybridTrainEntity = table.deepcopy(data.raw["locomotive"]["locomotive"])
	HybridTrainEntity.name = "james-hybrid-train"
    HybridTrainEntity.minable = {mining_time = 0.5, result = "james-hybrid-train"}
	HybridTrainEntity.weight = 2000
	HybridTrainEntity.color = {r = 51, g = 153, b = 255, a = 1}
	
local HybridTrainItem = table.deepcopy(data.raw["item-with-entity-data"]["locomotive"])
	HybridTrainItem.name = "james-hybrid-train"
	HybridTrainItem.place_result = "james-hybrid-train"
	
LSlib.recipe.duplicate("locomotive", "james-hybrid-train")
LSlib.recipe.editIngredient("james-hybrid-train", "engine-unit", "engine-unit", 0.5)
LSlib.recipe.addIngredient("james-hybrid-train", "electric-engine-unit", 10, "item")
LSlib.recipe.addIngredient("james-hybrid-train", "copper-cable", 30, "item")
LSlib.recipe.editResult("james-hybrid-train", "locomotive", "james-hybrid-train", 1)

data:extend({HybridTrainEntity, HybridTrainItem})
if settings.startup["train-tiers"].value then
	for i, v in pairs({2,3}) do
		local locomotive_entity = table.deepcopy(data.raw.locomotive["james-hybrid-train"])
		locomotive_entity.name = "james-hybrid-train-"..tostring(v)
		locomotive_entity.weight = data.raw.locomotive["james-hybrid-train"].weight + data.raw.locomotive["james-hybrid-train"].weight*v/2
		locomotive_entity.max_speed = data.raw.locomotive["james-hybrid-train"].max_speed*v
		locomotive_entity.braking_force = data.raw.locomotive["james-hybrid-train"].braking_force*v
		locomotive_entity.max_power = LocomotivePower[i]
		locomotive_entity.minable = {mining_time = 0.5, result = "james-hybrid-train-"..tostring(v)}
		locomotive_entity.color = {r = 51, g = 153, b = 255, a = 1}
		
		local locomotive_item = table.deepcopy(data.raw["item-with-entity-data"]["james-hybrid-train"])
		locomotive_item.name = "james-hybrid-train-"..tostring(v)
		locomotive_item.place_result = "james-hybrid-train-"..tostring(v)

		LSlib.recipe.duplicate("james-hybrid-train", "james-hybrid-train-"..tostring(v))
		data:extend({locomotive_entity, locomotive_item})
	end
	LSlib.recipe.addIngredient("james-hybrid-train-2", "james-hybrid-train", 1, "item")
	LSlib.recipe.editResult("james-hybrid-train-2", "james-hybrid-train", "james-hybrid-train-2", 1)
	LSlib.recipe.addIngredient("james-hybrid-train-3", "james-hybrid-train-2", 1, "item")
	LSlib.recipe.editResult("james-hybrid-train-3", "james-hybrid-train", "james-hybrid-train-3", 1)
end
--[[if settings.startup["diesel-trains"].value then

end
if settings.startup["steam-trains"].value then

end]]

data:extend({
	{
		type = "technology",
		name = "hybrid-trains",
		icon_size = 64,
		icon = "__base__/graphics/icons/steam-turbine.png",
		prerequisites = {"railway", "electric-engine"},
		effects = {
			{
				type = "unlock-recipe",
				recipe = "james-hybrid-train"
			},
		},
		unit = {
			count = 100,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
			},
			time = 30,
		},
		order = "d-a",
	},
})
if settings.startup["train-tiers"].value then
	data:extend({
		{
			type = "technology",
			name = "mid-speed-hybrid-trains",
			icon_size = 64,
			icon = "__base__/graphics/icons/steam-turbine.png",
			prerequisites = { "mid-speed-trains", "hybrid-trains"},
			effects = {
				{
					type = "unlock-recipe",
					recipe = "james-hybrid-train-2"
				},
			},
			unit = {
				count = 100,
				ingredients = {
					{"automation-science-pack", 1},
					{"logistic-science-pack", 1},
					{"chemical-science-pack", 1},
				},
				time = 30,
			},
			order = "d-a",
		},
		{
			type = "technology",
			name = "high-speed-hybrid-trains",
			icon_size = 64,
			icon = "__base__/graphics/icons/steam-turbine.png",
			prerequisites = { "high-speed-trains", "mid-speed-hybrid-trains" },
			effects = {
				{
					type = "unlock-recipe",
					recipe = "james-hybrid-train-3"
				},
			},
			unit = {
				count = 100,
				ingredients = {
					{"automation-science-pack", 1},
					{"logistic-science-pack", 1},
					{"chemical-science-pack", 1},
				},
				time = 30,
			},
			order = "d-a",
		},
	})
end