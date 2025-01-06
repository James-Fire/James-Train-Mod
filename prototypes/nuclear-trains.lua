local LocomotivePower = { "2.5MW", "5MW", "10MW" }

data.raw["locomotive"]["locomotive"].energy_source.effectivity = 0.8
data.raw.item["uranium-fuel-cell"].fuel_acceleration_multiplier = 1.9
data.raw.item["uranium-fuel-cell"].fuel_top_speed_multiplier = 1.9

local NuclearTrainEntity = table.deepcopy(data.raw["locomotive"]["locomotive"])
	NuclearTrainEntity.name = "james-nuclear-train"
	NuclearTrainEntity.icon = Modname.."/graphics/nuclear-train.png"
    NuclearTrainEntity.minable = {mining_time = 0.5, result = "james-nuclear-train"}
	NuclearTrainEntity.max_power = LocomotivePower[1]
	NuclearTrainEntity.energy_source.effectivity = 0.9
	NuclearTrainEntity.weight = 6000
	NuclearTrainEntity.energy_source.fuel_categories = {"nuclear"}
	NuclearTrainEntity.color = {r = 5.5, g = 100, b = 22.7, a = 155}
	
local NuclearTrainItem = table.deepcopy(data.raw["item-with-entity-data"]["locomotive"])
	NuclearTrainItem.name = "james-nuclear-train"
	NuclearTrainItem.icons = {
		{
			icon = Modname.."/graphics/nuclear-train.png",
			scale = 2
		},
		{
			icon = "__base__/graphics/icons/tooltips/tooltip-category-nuclear.png",
			icon_size = 32,
			scale = 2,
			icon_mipmaps = 2,
		}
	}
	NuclearTrainItem.place_result = "james-nuclear-train"
	
LSlib.recipe.duplicate("locomotive", "james-nuclear-train")
LSlib.recipe.editIngredient("james-nuclear-train", "engine-unit", "engine-unit", 0.5)
LSlib.recipe.addIngredient("james-nuclear-train", "electric-engine-unit", 20, "item")
LSlib.recipe.addIngredient("james-nuclear-train", "copper-cable", 60, "item")
LSlib.recipe.addIngredient("james-nuclear-train", "concrete", 20, "item")
LSlib.recipe.editResult("james-nuclear-train", "locomotive", "james-nuclear-train", 1)

data:extend({NuclearTrainEntity, NuclearTrainItem})
if settings.startup["train-tiers"].value then
	for i, v in pairs({2,3}) do
		local locomotive_entity = table.deepcopy(data.raw.locomotive["james-nuclear-train"])
		locomotive_entity.name = "james-nuclear-train-"..tostring(v)
		locomotive_entity.icon = Modname.."/graphics/nuclear-train.png"
		locomotive_entity.weight = data.raw.locomotive["james-nuclear-train"].weight + data.raw.locomotive["james-nuclear-train"].weight*v/2
		locomotive_entity.max_speed = data.raw.locomotive["james-nuclear-train"].max_speed*v
		locomotive_entity.braking_force = data.raw.locomotive["james-nuclear-train"].braking_force*v
		locomotive_entity.max_power = LocomotivePower[v]
		locomotive_entity.minable = {mining_time = 0.5, result = "james-nuclear-train-"..tostring(v)}
		
		local locomotive_item = table.deepcopy(data.raw["item-with-entity-data"]["james-nuclear-train"])
		locomotive_item.name = "james-nuclear-train-"..tostring(v)
		locomotive_item.icon = Modname.."/graphics/nuclear-train.png"
		locomotive_item.place_result = "james-nuclear-train-"..tostring(v)

		LSlib.recipe.duplicate("james-nuclear-train", "james-nuclear-train-"..tostring(v))
		data:extend({locomotive_entity, locomotive_item})
	end
	LSlib.recipe.addIngredient("james-nuclear-train-2", "james-nuclear-train", 1, "item")
	LSlib.recipe.editResult("james-nuclear-train-2", "james-nuclear-train", "james-nuclear-train-2", 1)
	LSlib.recipe.addIngredient("james-nuclear-train-3", "james-nuclear-train-2", 1, "item")
	LSlib.recipe.editResult("james-nuclear-train-3", "james-nuclear-train", "james-nuclear-train-3", 1)
end
--[[if settings.startup["diesel-trains"].value then

end
if settings.startup["steam-trains"].value then

end]]

data:extend({
	{
		type = "technology",
		name = "nuclear-trains",
		icons = {
			{
				icon = "__James-Train-Mod__/graphics/Technology-Backing.png",
				icon_size = 128,
			},
			{
				icon = "__base__/graphics/icons/locomotive.png",
				icon_size = 64,
				shift = {0, 0},
				icon_mipmaps = 4,
			},
			{
				icon = "__base__/graphics/icons/tooltips/tooltip-category-nuclear.png",
				icon_size = 40,
				scale = 1,
				shift = {0, 0},
				icon_mipmaps = 2,
			},
			{
				icon = "__James-Train-Mod__/graphics/speed.png",
				icon_size = 64,
				scale = 1/2,
				shift = {48, 48},
			},
		},
		prerequisites = {"railway", "electric-engine", "nuclear-power"},
		effects = {
			{
				type = "unlock-recipe",
				recipe = "james-nuclear-train"
			},
		},
		unit = {
			count = 300,
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
if settings.startup["train-tiers"].value then
	data:extend({
		{
			type = "technology",
			name = "mid-speed-nuclear-trains",
			icons = {
				{
					icon = "__James-Train-Mod__/graphics/Technology-Backing.png",
					icon_size = 128,
				},
				{
					icon = "__base__/graphics/icons/locomotive.png",
					icon_size = 64,
					shift = {0, 0},
					icon_mipmaps = 4,
				},
				{
					icon = "__base__/graphics/icons/tooltips/tooltip-category-nuclear.png",
					icon_size = 40,
					scale = 1,
					shift = {0, 0},
					icon_mipmaps = 2,
				},
				{
					icon = "__James-Train-Mod__/graphics/speed.png",
					icon_size = 64,
					scale = 1/2,
					shift = {15, 48},
				},
				{
					icon = "__James-Train-Mod__/graphics/speed.png",
					icon_size = 64,
					scale = 1/2,
					shift = {48, 48},
				},

			},
			prerequisites = { "mid-speed-trains", "nuclear-trains"},
			effects = {
				{
					type = "unlock-recipe",
					recipe = "james-nuclear-train-2"
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
		{
			type = "technology",
			name = "high-speed-nuclear-trains",
			icons = {
				{
					icon = "__James-Train-Mod__/graphics/Technology-Backing.png",
					icon_size = 128,
				},
				{
					icon = "__base__/graphics/icons/locomotive.png",
					icon_size = 64,
					shift = {0, 0},
					icon_mipmaps = 4,
				},
				{
					icon = "__base__/graphics/icons/tooltips/tooltip-category-nuclear.png",
					icon_size = 40,
					scale = 1,
					shift = {0, 0},
					icon_mipmaps = 2,
				},

				{
					icon = "__James-Train-Mod__/graphics/speed.png",
					icon_size = 64,
					scale = 1/2,
					shift = {32, 18},
				},
				{
					icon = "__James-Train-Mod__/graphics/speed.png",
					icon_size = 64,
					scale = 1/2,
					shift = {15, 48},
				},
				{
					icon = "__James-Train-Mod__/graphics/speed.png",
					icon_size = 64,
					scale = 1/2,
					shift = {48, 48},
				},

			},
			prerequisites = { "high-speed-trains", "mid-speed-nuclear-trains" },
			effects = {
				{
					type = "unlock-recipe",
					recipe = "james-nuclear-train-3"
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