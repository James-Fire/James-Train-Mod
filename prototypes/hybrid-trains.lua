local HybridTrainEntity = table.deepcopy(data.raw["locomotive"]["locomotive"])
	HybridTrainEntity.name = "james-hybrid-train"
    HybridTrainEntity.minable = {mining_time = 0.5, result = "james-hybrid-train"}
	HybridTrainEntity.weight = 2000
	
local HybridTrainItem = table.deepcopy(data.raw["item-with-entity-data"]["locomotive"])
	HybridTrainItem.name = "james-hybrid-train"
	HybridTrainItem.place_result = "james-hybrid-train"
	
LSlib.recipe.duplicate("locomotive", "hybrid-train")
LSlib.recipe.editIngredient("hybrid-train", "engine-unit", "engine-unit", 0.5)
LSlib.recipe.addIngredient("hybrid-train", "electric-engine-unit", 10, "item")
LSlib.recipe.addIngredient("hybrid-train", "copper-cable", 30, "item")

if settings.startup["train-tiers"].value then

end
--[[if settings.startup["diesel-trains"].value then

end
if settings.startup["steam-trains"].value then

end]]

data:extend({HybridTrainEntity, HybridTrainItem,
	{
		type = "technology",
		name = "hybrid-trains",
		icon_size = 64,
		icon = "__base__/graphics/icons/steam-turbine.png",
		prerequisites = {"railway", "electric-engine"},
		effects = {
			{
				type = "unlock-recipe",
				recipe = "hybrid-train"
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