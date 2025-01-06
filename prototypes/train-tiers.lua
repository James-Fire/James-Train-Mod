local LocomotivePower = { "1MW", "2MW" }

for i, v in pairs({2,3}) do
	local locomotive_entity = table.deepcopy(data.raw.locomotive["locomotive"])
	locomotive_entity.name = "locomotive-"..tostring(v)
	locomotive_entity.weight = data.raw.locomotive["locomotive"].weight + data.raw.locomotive["locomotive"].weight*v/2
    locomotive_entity.max_speed = data.raw.locomotive["locomotive"].max_speed*v
    locomotive_entity.braking_force = data.raw.locomotive["locomotive"].braking_force*v
	locomotive_entity.max_power = LocomotivePower[i]
    locomotive_entity.minable = {mining_time = 0.5, result = "locomotive-"..tostring(v)}
	
	local locomotive_item = table.deepcopy(data.raw["item-with-entity-data"]["locomotive"])
	locomotive_item.name = "locomotive-"..tostring(v)
	locomotive_item.place_result = "locomotive-"..tostring(v)

	LSlib.recipe.duplicate("locomotive", "locomotive-"..tostring(v))
	data:extend({locomotive_entity, locomotive_item})
end
	LSlib.recipe.addIngredient("locomotive-2", "locomotive", 1, "item")
	LSlib.recipe.addIngredient("locomotive-3", "locomotive-2", 1, "item")
	LSlib.recipe.editResult("locomotive-2", "locomotive", "locomotive-2", 1)
	LSlib.recipe.editResult("locomotive-3", "locomotive", "locomotive-3", 1)

data:extend({
	{
		type = "technology",
		name = "mid-speed-trains",
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
		prerequisites = { "railway", "chemical-science-pack" },
		effects = {
			{
				type = "unlock-recipe",
				recipe = "locomotive-2"
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
		name = "high-speed-trains",
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

		prerequisites = { "mid-speed-trains", "production-science-pack" },
		effects = {
			{
				type = "unlock-recipe",
				recipe = "locomotive-3"
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
})