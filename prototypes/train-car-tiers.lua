local Wagons = { "cargo-wagon", "fluid-wagon", "artillery-wagon" }

data.raw["cargo-wagon"]["cargo-wagon"].max_speed = 1.3
data.raw["cargo-wagon"]["cargo-wagon"].inventory_size = data.raw["cargo-wagon"]["cargo-wagon"].inventory_size*0.75
data.raw["fluid-wagon"]["fluid-wagon"].max_speed = 1.3
data.raw["fluid-wagon"]["fluid-wagon"].capacity = data.raw["fluid-wagon"]["fluid-wagon"].capacity*0.8
data.raw["artillery-wagon"]["artillery-wagon"].max_speed = 1.3

for i, wagon in pairs(Wagons) do
	for j, v in pairs({2,3}) do
		local wagon_entity = table.deepcopy(data.raw[wagon][wagon])
		wagon_entity.name = wagon.."-"..tostring(v)
		wagon_entity.weight = data.raw[wagon][wagon].weight + data.raw[wagon][wagon].weight*v/2
		wagon_entity.max_speed = data.raw[wagon][wagon].max_speed*(v-0.5*i)
		wagon_entity.braking_force = data.raw[wagon][wagon].braking_force*v
		if data.raw[wagon][wagon].inventory_size then
			wagon_entity.inventory_size = data.raw[wagon][wagon].inventory_size*v
		elseif data.raw[wagon][wagon].capacity then
			wagon_entity.capacity = data.raw[wagon][wagon].capacity*v
		end
		wagon_entity.minable = {mining_time = 0.5, result = wagon.."-"..tostring(v)}
		
		local wagon_item = table.deepcopy(data.raw["item-with-entity-data"][wagon])
		wagon_item.name = wagon.."-"..tostring(v)
		wagon_item.place_result = wagon.."-"..tostring(v)

		LSlib.recipe.duplicate(wagon, wagon.."-"..tostring(v))
		data:extend({wagon_entity, wagon_item})
	end
	LSlib.recipe.addIngredient(wagon.."-2", wagon, 1, "item")
	LSlib.recipe.addIngredient(wagon.."-3", wagon.."-2", 1, "item")
	LSlib.recipe.editResult(wagon.."-2", wagon, wagon.."-2", 1)
	LSlib.recipe.editResult(wagon.."-3", wagon, wagon.."-3", 1)
end

data:extend({
	{
		type = "technology",
		name = "mid-speed-wagons",
		icons = {
			{
				icon = "__James-Train-Mod__/graphics/Technology-Backing.png",
				icon_size = 128,
			},
			{
				icon = "__base__/graphics/icons/cargo-wagon.png",
				icon_size = 64,
				icon_mipmaps = 4,
				shift = {20, -28},
			},
			{
				icon = "__base__/graphics/icons/fluid-wagon.png",
				icon_size = 64,
				icon_mipmaps = 4,
				shift = {-24, 12},
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
		prerequisites = { "railway", "chemical-science-pack", "fluid-wagon" },
		effects = {
			{
				type = "unlock-recipe",
				recipe = "cargo-wagon-2"
			},
			{
				type = "unlock-recipe",
				recipe = "fluid-wagon-2"
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
		name = "mid-speed-military-wagons",
		icons = {
			{
				icon = "__James-Train-Mod__/graphics/Technology-Backing.png",
				icon_size = 128,
			},
			{
				icon = "__base__/graphics/icons/artillery-wagon.png",
				icon_size = 64,
				icon_mipmaps = 4,
				shift = {0, 0},
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
		prerequisites = { "mid-speed-wagons", "artillery" },
		effects = {
			{
				type = "unlock-recipe",
				recipe = "artillery-wagon-2"
			},
		},
		unit = {
			count = 100,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"military-science-pack", 1},
			},
			time = 30,
		},
		order = "d-a",
	},
	{
		type = "technology",
		name = "high-speed-wagons",
		icons = {
			{
				icon = "__James-Train-Mod__/graphics/Technology-Backing.png",
				icon_size = 128,
			},
			{
				icon = "__base__/graphics/icons/cargo-wagon.png",
				icon_size = 64,
				icon_mipmaps = 4,
				shift = {20, -28},
			},
			{
				icon = "__base__/graphics/icons/fluid-wagon.png",
				icon_size = 64,
				icon_mipmaps = 4,
				shift = {-24, 12},
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
		prerequisites = { "mid-speed-wagons", "production-science-pack" },
		effects = {
			{
				type = "unlock-recipe",
				recipe = "cargo-wagon-3"
			},
			{
				type = "unlock-recipe",
				recipe = "fluid-wagon-3"
			},
		},
		unit = {
			count = 100,
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
		name = "high-speed-military-wagons",
		icons = {
			{
				icon = "__James-Train-Mod__/graphics/Technology-Backing.png",
				icon_size = 128,
			},
			{
				icon = "__base__/graphics/icons/artillery-wagon.png",
				icon_size = 64,
				icon_mipmaps = 4,
				shift = {0, 0},
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
		prerequisites = { "high-speed-wagons", "mid-speed-military-wagons" },
		effects = {
			{
				type = "unlock-recipe",
				recipe = "artillery-wagon-3"
			},
		},
		unit = {
			count = 100,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"military-science-pack", 1},
			},
			time = 30,
		},
		order = "d-a",
	},
})
if settings.startup["train-tiers"].value then
	LSlib.technology.movePrerequisite("mid-speed-wagons", "railway", "mid-speed-trains")
	LSlib.technology.addPrerequisite("high-speed-wagons", "high-speed-trains")
end