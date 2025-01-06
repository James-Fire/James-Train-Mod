local Wagons = { "cargo-wagon", "fluid-wagon", "artillery-wagon" }

if settings.startup["train-car-tiers"].value then
	for i, wagon in pairs(Wagons) do
		for j, v in pairs({1,2,3}) do
			local wagon_entity = table.deepcopy(data.raw[wagon][wagon])
			wagon_entity.name = wagon.."-electric-"..tostring(v)
			wagon_entity.max_speed = data.raw[wagon][wagon].max_speed*v
			wagon_entity.weight = 0.01
			wagon_entity.braking_force = 0.001
			if data.raw[wagon][wagon].inventory_size then
				wagon_entity.inventory_size = data.raw[wagon][wagon].inventory_size*v
			elseif data.raw[wagon][wagon].capacity then
				wagon_entity.capacity = data.raw[wagon][wagon].capacity*v
			end
			wagon_entity.minable = {mining_time = 0.5, result = wagon.."-electric-"..tostring(v)}
			
			local wagon_item = table.deepcopy(data.raw["item-with-entity-data"][wagon])
			wagon_item.name = wagon.."-electric-"..tostring(v)
			wagon_item.icons = {
				{
					icon = "__base__/graphics/icons/"..wagon..".png",
					scale = 2
				},
				{
					icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
					icon_size = 32,
					scale = 2,
					icon_mipmaps = 2,
				},
			}
			wagon_item.place_result = wagon.."-electric-"..tostring(v)

			LSlib.recipe.duplicate(wagon, wagon.."-electric-"..tostring(v))
			data:extend({wagon_entity, wagon_item})
		end
		LSlib.recipe.addIngredient(wagon.."-electric-1", "electric-engine-unit", 8, "item")
		LSlib.recipe.addIngredient(wagon.."-electric-1", "copper-cable", 40, "item")
		LSlib.recipe.addIngredient(wagon.."-electric-2", wagon.."-electric-1", 1, "item")
		LSlib.recipe.addIngredient(wagon.."-electric-2", "copper-cable", 40, "item")
		LSlib.recipe.addIngredient(wagon.."-electric-3", wagon.."-electric-2", 1, "item")
		LSlib.recipe.addIngredient(wagon.."-electric-3", "copper-cable", 40, "item")
		LSlib.recipe.editResult(wagon.."-electric-1", wagon, wagon.."-electric-1", 1)
		LSlib.recipe.editResult(wagon.."-electric-2", wagon, wagon.."-electric-2", 1)
		LSlib.recipe.editResult(wagon.."-electric-3", wagon, wagon.."-electric-3", 1)
	end
else
--Wagons(s)
local ElectricCargoWagonEntity = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])
	ElectricCargoWagonEntity.name = "cargo-wagon-electric-1"
    ElectricCargoWagonEntity.minable = {mining_time = 0.5, result = "cargo-wagon-electric-1"}
    ElectricCargoWagonEntity.weight = 0.01
    ElectricCargoWagonEntity.braking_force = 0.001
	
local ElectricCargoWagonItem = table.deepcopy(data.raw["item-with-entity-data"]["cargo-wagon"])
	ElectricCargoWagonItem.name = "cargo-wagon-electric-1"
	ElectricCargoWagonItem.icons = {
		{
			icon = "__base__/graphics/icons/cargo-wagon.png",
			scale = 2
		},
		{
			icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
			icon_size = 32,
			scale = 2,
			icon_mipmaps = 2,
		},
	}
	ElectricCargoWagonItem.place_result = "cargo-wagon-electric-1"
	
local ElectricFluidWagonEntity = table.deepcopy(data.raw["fluid-wagon"]["fluid-wagon"])
	ElectricFluidWagonEntity.name = "fluid-wagon-electric-1"
    ElectricFluidWagonEntity.minable = {mining_time = 0.5, result = "fluid-wagon-electric-1"}
    ElectricFluidWagonEntity.weight = 0.01
    ElectricFluidWagonEntity.braking_force = 0.001
	
local ElectricFluidWagonItem = table.deepcopy(data.raw["item-with-entity-data"]["fluid-wagon"])
	ElectricFluidWagonItem.name = "fluid-wagon-electric-1"
	ElectricFluidWagonItem.icons = {
		{
			icon = "__base__/graphics/icons/fluid-wagon.png",
			scale = 2
		},
		{
			icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
			icon_size = 32,
			scale = 2,
			icon_mipmaps = 2,
		},
	}
	ElectricFluidWagonItem.place_result = "fluid-wagon-electric-1"
	
local ElectricArtilleryWagonEntity = table.deepcopy(data.raw["artillery-wagon"]["artillery-wagon"])
	ElectricArtilleryWagonEntity.name = "artillery-wagon-electric-1"
    ElectricArtilleryWagonEntity.minable = {mining_time = 0.5, result = "artillery-wagon-electric-1"}
    ElectricArtilleryWagonEntity.weight = 0.01
    ElectricArtilleryWagonEntity.braking_force = 0.001
	
local ElectricArtilleryWagonItem = table.deepcopy(data.raw["item-with-entity-data"]["artillery-wagon"])
	ElectricArtilleryWagonItem.name = "artillery-wagon-electric-1"
	ElectricArtilleryWagonItem.icons = {
		{
			icon = "__base__/graphics/icons/artillery-wagon.png",
			scale = 2
		},
		{
			icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
			icon_size = 32,
			scale = 2,
			icon_mipmaps = 2,
		},
	}
	ElectricArtilleryWagonItem.place_result = "artillery-wagon-electric-1"
	
data:extend({ElectricCargoWagonEntity, ElectricCargoWagonItem,
ElectricFluidWagonEntity, ElectricFluidWagonItem,
ElectricArtilleryWagonEntity, ElectricArtilleryWagonItem,
	{
		type = "recipe",
		name = "cargo-wagon-electric-1",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{type = "item", name = "cargo-wagon", amount = 1},
			{type = "item", name = "electric-engine-unit", amount = 8},
			{type = "item", name = "copper-cable", amount = 30},
			{type = "item", name = "electronic-circuit", amount = 10},
		},
		results = {{type = "item", name = "cargo-wagon-electric-1", amount = 1}},
	},
	{
		type = "recipe",
		name = "fluid-wagon-electric-1",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{type = "item", name = "fluid-wagon", amount = 1},
			{type = "item", name = "electric-engine-unit", amount = 8},
			{type = "item", name = "copper-cable", amount = 30},
			{type = "item", name = "electronic-circuit", amount = 10},
		},
		results = {{type = "item", name = "fluid-wagon-electric-1", amount = 1}},
	},
	{
		type = "recipe",
		name = "artillery-wagon-electric-1",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{type = "item", name = "artillery-wagon", amount = 1},
			{type = "item", name = "electric-engine-unit", amount = 8},
			{type = "item", name = "copper-cable", amount = 30},
			{type = "item", name = "electronic-circuit", amount = 10},
		},
		results = {{type = "item", name = "artillery-wagon-electric-1", amount = 1}},
	},
})
	
end

--Data extend everything, and make our hidden item
data:extend({
	{
		type = "technology",
		name = "electric-wagons",
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
				icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
				icon_size = 40,
				scale = 1,
				shift = {20, -28},
			},
			{
				icon = "__base__/graphics/icons/fluid-wagon.png",
				icon_size = 64,
				icon_mipmaps = 4,
				shift = {-24, 12},
			},
			{
				icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
				icon_size = 40,
				scale = 1,
				shift = {-24, 12},
			},
			{
				icon = "__James-Train-Mod__/graphics/speed.png",
				icon_size = 64,
				scale = 1/2,
				shift = {48, 48},
			},
		},
		prerequisites = { "railway", "electric-engine", "fluid-wagon" },
		effects = {
			{
				type = "unlock-recipe",
				recipe = "cargo-wagon-electric-1"
			},
			{
				type = "unlock-recipe",
				recipe = "fluid-wagon-electric-1"
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
		order = "a-1",
	},
	{
		type = "technology",
		name = "electric-military-wagons",
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
				icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
				icon_size = 40,
				scale = 1,
				shift = {0, 0},
			},
			{
				icon = "__James-Train-Mod__/graphics/speed.png",
				icon_size = 64,
				scale = 1/2,
				shift = {48, 48},
			},
		},
		prerequisites = { "railway", "electric-wagons" },
		effects = {
			{
				type = "unlock-recipe",
				recipe = "artillery-wagon-electric-1"
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
		order = "a-2",
	},
})
if settings.startup["train-car-tiers"].value then
	data:extend({
		{
			type = "technology",
			name = "mid-speed-electric-wagons",
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
					icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
					icon_size = 40,
					scale = 1,
					shift = {20, -28},
				},
				{
					icon = "__base__/graphics/icons/fluid-wagon.png",
					icon_size = 64,
					icon_mipmaps = 4,
					shift = {-24, 12},
				},
				{
					icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
					icon_size = 40,
					scale = 1,
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
			prerequisites = { "electric-wagons", "mid-speed-wagons" },
			effects = {
				{
					type = "unlock-recipe",
					recipe = "cargo-wagon-electric-2"
				},
				{
					type = "unlock-recipe",
					recipe = "fluid-wagon-electric-2"
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
			name = "mid-speed-electric-military-wagons",
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
					icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
					icon_size = 40,
					scale = 1,
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
			prerequisites = { "mid-speed-electric-wagons", "mid-speed-military-wagons", "electric-military-wagons" },
			effects = {
				{
					type = "unlock-recipe",
					recipe = "artillery-wagon-electric-2"
				},
			},
			unit = {
				count = 200,
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
			name = "high-speed-electric-wagons",
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
					icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
					icon_size = 40,
					scale = 1,
					shift = {20, -28},
				},
				{
					icon = "__base__/graphics/icons/fluid-wagon.png",
					icon_size = 64,
					icon_mipmaps = 4,
					shift = {-24, 12},
				},
				{
					icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
					icon_size = 40,
					scale = 1,
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
			prerequisites = { "mid-speed-electric-wagons", "high-speed-wagons" },
			effects = {
				{
					type = "unlock-recipe",
					recipe = "cargo-wagon-electric-3"
				},
				{
					type = "unlock-recipe",
					recipe = "fluid-wagon-electric-3"
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
			order = "a-3",
		},
		{
			type = "technology",
			name = "high-speed-electric-military-wagons",
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
					icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
					icon_size = 40,
					scale = 1,
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

			prerequisites = { "high-speed-electric-wagons", "high-speed-military-wagons", "mid-speed-electric-military-wagons" },
			effects = {
				{
					type = "unlock-recipe",
					recipe = "artillery-wagon-electric-3"
				},
			},
			unit = {
				count = 200,
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
end