--Train(s)
local ElectricTrainEntity = table.deepcopy(data.raw["locomotive"]["locomotive"])
	ElectricTrainEntity.name = "james-electric-train"
	ElectricTrainEntity.burner.fuel_inventory_size = 0
	ElectricTrainEntity.burner.smoke = nil
    ElectricTrainEntity.minable = {mining_time = 0.5, result = "james-electric-train"}
	
local ElectricTrainItem = table.deepcopy(data.raw["item-with-entity-data"]["locomotive"])
	ElectricTrainItem.name = "james-electric-train"
	ElectricTrainItem.place_result = "james-electric-train"

if settings.startup["train-tiers"].value then
	if settings.startup["electric-train-upgrade"].value then
	
	end
end

--Data extend everything, and make our hidden item
data:extend({ElectricTrainEntity, ElectricTrainItem,
	{
		type = "recipe",
		name = "james-electric-train",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{"locomotive", 1},
			{"electric-engine-unit", 8},
			{"copper-cable", 30},
			{"electronic-circuit", 10},
		},
		results = {{"james-electric-train",1}},
	},
	{
		type = "technology",
		name = "electric-trains",
		icon_size = 64,
		icon = "__base__/graphics/icons/steam-turbine.png",
		prerequisites = {"railway", "electric-engine"},
		effects = {
			{
				type = "unlock-recipe",
				recipe = "james-electric-train"
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