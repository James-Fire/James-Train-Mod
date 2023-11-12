--Train(s)
local ElectricCargoWagonEntity = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])
	ElectricCargoWagonEntity.name = "cargo-wagon-electric"
    ElectricCargoWagonEntity.minable = {mining_time = 0.5, result = "cargo-wagon-electric"}
    ElectricCargoWagonEntity.weight = 0.01
    ElectricCargoWagonEntity.braking_force = 0.001
    --ElectricCargoWagonEntity.braking_power = "1J"
	
local ElectricCargoWagonItem = table.deepcopy(data.raw["item-with-entity-data"]["cargo-wagon"])
	ElectricCargoWagonItem.name = "cargo-wagon-electric"
	ElectricCargoWagonItem.place_result = "cargo-wagon-electric"
	
local ElectricFluidWagonEntity = table.deepcopy(data.raw["fluid-wagon"]["fluid-wagon"])
	ElectricFluidWagonEntity.name = "fluid-wagon-electric"
    ElectricFluidWagonEntity.minable = {mining_time = 0.5, result = "fluid-wagon-electric"}
    ElectricFluidWagonEntity.weight = 0.01
    ElectricFluidWagonEntity.braking_force = 0.001
    --ElectricFluidWagonEntity.braking_power = "1J"
	
local ElectricFluidWagonItem = table.deepcopy(data.raw["item-with-entity-data"]["fluid-wagon"])
	ElectricFluidWagonItem.name = "fluid-wagon-electric"
	ElectricFluidWagonItem.place_result = "fluid-wagon-electric"
	
local ElectricArtilleryWagonEntity = table.deepcopy(data.raw["artillery-wagon"]["artillery-wagon"])
	ElectricArtilleryWagonEntity.name = "artillery-wagon-electric"
    ElectricArtilleryWagonEntity.minable = {mining_time = 0.5, result = "artillery-wagon-electric"}
    ElectricArtilleryWagonEntity.weight = 0.01
    ElectricArtilleryWagonEntity.braking_force = 0.001
    --ElectricArtilleryWagonEntity.braking_power = "1J"
	
local ElectricArtilleryWagonItem = table.deepcopy(data.raw["item-with-entity-data"]["artillery-wagon"])
	ElectricArtilleryWagonItem.name = "artillery-wagon-electric"
	ElectricArtilleryWagonItem.place_result = "artillery-wagon-electric"

if settings.startup["train-car-tiers"].value then

end

--Data extend everything, and make our hidden item
data:extend({ElectricCargoWagonEntity, ElectricCargoWagonItem,
ElectricFluidWagonEntity, ElectricFluidWagonItem,
ElectricArtilleryWagonEntity, ElectricArtilleryWagonItem,
	{
		type = "recipe",
		name = "cargo-wagon-electric",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{"cargo-wagon", 1},
			{"electric-engine-unit", 8},
			{"copper-cable", 30},
			{"electronic-circuit", 10},
		},
		results = {{"cargo-wagon-electric",1}},
	},
	{
		type = "recipe",
		name = "fluid-wagon-electric",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{"fluid-wagon", 1},
			{"electric-engine-unit", 8},
			{"copper-cable", 30},
			{"electronic-circuit", 10},
		},
		results = {{"fluid-wagon-electric",1}},
	},
	{
		type = "recipe",
		name = "artillery-wagon-electric",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{"artillery-wagon", 1},
			{"electric-engine-unit", 8},
			{"copper-cable", 30},
			{"electronic-circuit", 10},
		},
		results = {{"artillery-wagon-electric",1}},
	},
	{
		type = "technology",
		name = "electric-wagons",
		icon_size = 64,
		icon = "__base__/graphics/icons/steam-turbine.png",
		prerequisites = {"electric-engine"},
		effects = {
			{
				type = "unlock-recipe",
				recipe = "cargo-wagon-electric"
			},
			{
				type = "unlock-recipe",
				recipe = "fluid-wagon-electric"
			},
			{
				type = "unlock-recipe",
				recipe = "artillery-wagon-electric"
			},
		},
		unit = {
			count = 50,
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