local LocomotivePower = { "1MW", "2MW", "4MW" }

data.raw["locomotive"]["locomotive"].burner.effectivity = 0.8

--Train(s)
local ElectricTrainEntity = table.deepcopy(data.raw["locomotive"]["locomotive"])
	ElectricTrainEntity.name = "james-electric-train"
	ElectricTrainEntity.icon = Modname.."/graphics/electric-train.png"
	ElectricTrainEntity.burner.fuel_inventory_size = 0
	ElectricTrainEntity.burner.effectivity = 1
	ElectricTrainEntity.max_power = LocomotivePower[1]
	ElectricTrainEntity.braking_force = ElectricTrainEntity.braking_force*2
	ElectricTrainEntity.burner.smoke = nil
    ElectricTrainEntity.minable = {mining_time = 0.5, result = "james-electric-train"}
	ElectricTrainEntity.weight = 1500
	ElectricTrainEntity.color = {r = 0, g = 0, b = 255, a = 1}

local ElectricTrainItem = table.deepcopy(data.raw["item-with-entity-data"]["locomotive"])
	ElectricTrainItem.name = "james-electric-train"
	ElectricTrainItem.icon = Modname.."/graphics/electric-train.png"
	ElectricTrainItem.place_result = "james-electric-train"

data:extend({ElectricTrainEntity, ElectricTrainItem,
	{
		type = "recipe",
		name = "james-electric-train",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{"steel-plate", 30},
			{"electric-engine-unit", 8},
			{"copper-cable", 30},
			{"electronic-circuit", 10},
		},
		result = "james-electric-train",
	},
})

if settings.startup["train-tiers"].value then
	for i, v in pairs({2,3}) do
		local locomotive_entity = table.deepcopy(data.raw.locomotive["james-electric-train"])
		locomotive_entity.name = "james-electric-train-"..tostring(v)
		locomotive_entity.icon = Modname.."/graphics/electric-train.png"
		locomotive_entity.weight = data.raw.locomotive["james-electric-train"].weight + data.raw.locomotive["james-electric-train"].weight*v/2
		locomotive_entity.max_speed = data.raw.locomotive["james-electric-train"].max_speed*v
		locomotive_entity.braking_force = data.raw.locomotive["james-electric-train"].braking_force*v
		locomotive_entity.max_power = LocomotivePower[v]
		locomotive_entity.minable = {mining_time = 0.5, result = "james-electric-train-"..tostring(v)}
		locomotive_entity.color = {r = 0, g = 0, b = 255, a = 255}
		
		local locomotive_item = table.deepcopy(data.raw["item-with-entity-data"]["james-electric-train"])
		locomotive_item.name = "james-electric-train-"..tostring(v)
		locomotive_item.icon = Modname.."/graphics/electric-train.png"
		locomotive_item.place_result = "james-electric-train-"..tostring(v)

		LSlib.recipe.duplicate("james-electric-train", "james-electric-train-"..tostring(v))
		data:extend({locomotive_entity, locomotive_item})
	end
	LSlib.recipe.editResult("james-electric-train-2", "james-electric-train", "james-electric-train-2", 1)
	LSlib.recipe.editResult("james-electric-train-3", "james-electric-train", "james-electric-train-3", 1)
	if settings.startup["electric-train-upgrade"].value then
		LSlib.recipe.addIngredient("james-electric-train-2", "locomotive-2", 1, "item")
		LSlib.recipe.addIngredient("james-electric-train-3", "locomotive-3", 1, "item")
	else
		LSlib.recipe.addIngredient("james-electric-train-2", "james-electric-train", 1, "item")
		LSlib.recipe.addIngredient("james-electric-train-3", "james-electric-train-2", 1, "item")
	end
end
data:extend({
	{
		type = "technology",
		name = "electric-trains",
		icons = {
			{
				icon = "__base__/graphics/icons/locomotive.png",
				icon_size = 64,
				shift = {0, 0},
				icon_mipmaps = 4,
			},
			{
				icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
				icon_size = 32,
				shift = {0, 0},
			},
		},
		prerequisites = {"railway", "electric-engine", "electric-energy-distribution-2"},
		effects = {
			{
				type = "unlock-recipe",
				recipe = "james-electric-train"
			},
		},
		unit = {
			count = 300,
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

if settings.startup["hybrid-trains"].value then
	LSlib.technology.movePrerequisite("electric-trains", "railway", "hybrid-trains")
end
if settings.startup["train-tiers"].value then
	data:extend({
		{
			type = "technology",
			name = "mid-speed-electric-trains",
			icons = {
				{
					icon = "__base__/graphics/icons/locomotive.png",
					icon_size = 64,
					shift = {0, 0},
					icon_mipmaps = 4,
				},
				{
					icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
					icon_size = 32,
					shift = {0, 0},
				},
			},
			prerequisites = { "mid-speed-trains", "electric-trains"},
			effects = {
				{
					type = "unlock-recipe",
					recipe = "james-electric-train-2"
				},
			},
			unit = {
				count = 200,
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
			name = "high-speed-electric-trains",
			icons = {
				{
					icon = "__base__/graphics/icons/locomotive.png",
					icon_size = 64,
					shift = {0, 0},
					icon_mipmaps = 4,
				},
				{
					icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
					icon_size = 32,
					shift = {0, 0},
				},
			},
			prerequisites = { "high-speed-trains", "mid-speed-electric-trains" },
			effects = {
				{
					type = "unlock-recipe",
					recipe = "james-electric-train-3"
				},
			},
			unit = {
				count = 200,
				ingredients = {
					{"automation-science-pack", 1},
					{"logistic-science-pack", 1},
					{"chemical-science-pack", 1},
					{"production-science-pack", 1},
				},
				time = 30,
			},
			order = "d-a",
		},
	})
end