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
			wagon_item.place_result = wagon.."-electric-"..tostring(v)

			LSlib.recipe.duplicate(wagon, wagon.."-electric-"..tostring(v))
			data:extend({wagon_entity, wagon_item})
		end
		LSlib.recipe.addIngredient(wagon.."-electric-1", "electric-engine-unit", 8, "item")
		LSlib.recipe.addIngredient(wagon.."-electric-2", wagon.."-electric-1", 1, "item")
		LSlib.recipe.addIngredient(wagon.."-electric-3", wagon.."-electric-2", 1, "item")
		LSlib.recipe.editResult(wagon.."-electric-1", wagon, wagon.."-electric-1", 1)
		LSlib.recipe.editResult(wagon.."-electric-2", wagon, wagon.."-electric-2", 1)
		LSlib.recipe.editResult(wagon.."-electric-3", wagon, wagon.."-electric-3", 1)
	end
else
--Wagons(s)
local ElectricCargoWagonEntity = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])
	ElectricCargoWagonEntity.name = "cargo-wagon-electric"
    ElectricCargoWagonEntity.minable = {mining_time = 0.5, result = "cargo-wagon-electric"}
    ElectricCargoWagonEntity.weight = 0.01
    ElectricCargoWagonEntity.braking_force = 0.001
	
local ElectricCargoWagonItem = table.deepcopy(data.raw["item-with-entity-data"]["cargo-wagon"])
	ElectricCargoWagonItem.name = "cargo-wagon-electric"
	ElectricCargoWagonItem.place_result = "cargo-wagon-electric"
	
local ElectricFluidWagonEntity = table.deepcopy(data.raw["fluid-wagon"]["fluid-wagon"])
	ElectricFluidWagonEntity.name = "fluid-wagon-electric"
    ElectricFluidWagonEntity.minable = {mining_time = 0.5, result = "fluid-wagon-electric"}
    ElectricFluidWagonEntity.weight = 0.01
    ElectricFluidWagonEntity.braking_force = 0.001
	
local ElectricFluidWagonItem = table.deepcopy(data.raw["item-with-entity-data"]["fluid-wagon"])
	ElectricFluidWagonItem.name = "fluid-wagon-electric"
	ElectricFluidWagonItem.place_result = "fluid-wagon-electric"
	
local ElectricArtilleryWagonEntity = table.deepcopy(data.raw["artillery-wagon"]["artillery-wagon"])
	ElectricArtilleryWagonEntity.name = "artillery-wagon-electric"
    ElectricArtilleryWagonEntity.minable = {mining_time = 0.5, result = "artillery-wagon-electric"}
    ElectricArtilleryWagonEntity.weight = 0.01
    ElectricArtilleryWagonEntity.braking_force = 0.001
	
local ElectricArtilleryWagonItem = table.deepcopy(data.raw["item-with-entity-data"]["artillery-wagon"])
	ElectricArtilleryWagonItem.name = "artillery-wagon-electric"
	ElectricArtilleryWagonItem.place_result = "artillery-wagon-electric"
	
data:extend({ElectricCargoWagonEntity, ElectricCargoWagonItem,
ElectricFluidWagonEntity, ElectricFluidWagonItem,
ElectricArtilleryWagonEntity, ElectricArtilleryWagonItem,
	{
		type = "recipe",
		name = "cargo-wagon-electric-1",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{"cargo-wagon", 1},
			{"electric-engine-unit", 8},
			{"copper-cable", 30},
			{"electronic-circuit", 10},
		},
		results = {{"cargo-wagon-electric-1",1}},
	},
	{
		type = "recipe",
		name = "fluid-wagon-electric-1",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{"fluid-wagon", 1},
			{"electric-engine-unit", 8},
			{"copper-cable", 30},
			{"electronic-circuit", 10},
		},
		results = {{"fluid-wagon-electric-1",1}},
	},
	{
		type = "recipe",
		name = "artillery-wagon-electric-1",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{"artillery-wagon", 1},
			{"electric-engine-unit", 8},
			{"copper-cable", 30},
			{"electronic-circuit", 10},
		},
		results = {{"artillery-wagon-electric-1",1}},
	},
})
	
end

--Data extend everything, and make our hidden item
data:extend({
	{
		type = "technology",
		name = "electric-wagons",
		icon_size = 64,
		icon = "__base__/graphics/icons/steam-turbine.png",
		prerequisites = { "railway", "electric-engine" },
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
			count = 250,
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
		name = "electric-military-wagons",
		icon_size = 64,
		icon = "__base__/graphics/icons/steam-turbine.png",
		prerequisites = { "railway", "electric-wagons" },
		effects = {
			{
				type = "unlock-recipe",
				recipe = "artillery-wagon-electric-1"
			},
		},
		unit = {
			count = 250,
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
if settings.startup["train-car-tiers"].value then
	data:extend({
		{
			type = "technology",
			name = "mid-speed-electric-wagons",
			icon_size = 64,
			icon = "__base__/graphics/icons/steam-turbine.png",
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
			name = "mid-speed-electric-military-wagons",
			icon_size = 64,
			icon = "__base__/graphics/icons/steam-turbine.png",
			prerequisites = { "mid-speed-electric-wagons", "artillery-wagon" },
			effects = {
				{
					type = "unlock-recipe",
					recipe = "artillery-wagon-electric-2"
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
			name = "high-speed-electric-wagons",
			icon_size = 64,
			icon = "__base__/graphics/icons/steam-turbine.png",
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
			name = "high-speed-electric-military-wagons",
			icon_size = 64,
			icon = "__base__/graphics/icons/steam-turbine.png",
			prerequisites = { "high-speed-electric-wagons", "mid-speed-artillery-wagons" },
			effects = {
				{
					type = "unlock-recipe",
					recipe = "artillery-wagon-electric-3"
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
end