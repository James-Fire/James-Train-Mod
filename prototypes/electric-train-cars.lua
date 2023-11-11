--Train(s)
local ElectricCargoWagonEntity = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])
	ElectricCargoWagonEntity.name = "james-electric-cargo-wagon"
    ElectricCargoWagonEntity.minable = {mining_time = 0.5, result = "james-electric-cargo-wagon"}
    ElectricCargoWagonEntity.weight = 0
	
local ElectricCargoWagonItem = table.deepcopy(data.raw["item-with-entity-data"]["cargo-wagon"])
	ElectricCargoWagonItem.name = "james-electric-cargo-wagon"
	ElectricCargoWagonItem.place_result = "james-electric-cargo-wagon"
	
local ElectricFluidWagonEntity = table.deepcopy(data.raw["fluid-wagon"]["fluid-wagon"])
	ElectricFluidWagonEntity.name = "james-electric-fluid-wagon"
    ElectricFluidWagonEntity.minable = {mining_time = 0.5, result = "james-electric-fluid-wagon"}
    ElectricFluidWagonEntity.weight = 0
	
local ElectricFluidWagonItem = table.deepcopy(data.raw["item-with-entity-data"]["fluid-wagon"])
	ElectricFluidWagonItem.name = "james-electric-fluid-wagon"
	ElectricFluidWagonItem.place_result = "james-electric-fluid-wagon"
	
local ElectricArtilleryWagonEntity = table.deepcopy(data.raw["artillery-wagon"]["artillery-wagon"])
	ElectricArtilleryWagonEntity.name = "james-electric-artillery-wagon"
    ElectricArtilleryWagonEntity.minable = {mining_time = 0.5, result = "james-electric-artillery-wagon"}
    ElectricArtilleryWagonEntity.weight = 0
	
local ElectricArtilleryWagonItem = table.deepcopy(data.raw["item-with-entity-data"]["artillery-wagon"])
	ElectricArtilleryWagonItem.name = "james-electric-artillery-wagon"
	ElectricArtilleryWagonItem.place_result = "james-electric-artillery-wagon"

if settings.startup["train-car-tiers"].value then

end

--Data extend everything, and make our hidden item
data:extend({ElectricCargoWagonEntity, ElectricCargoWagonItem,
ElectricFluidWagonEntity, ElectricFluidWagonItem,
ElectricArtilleryWagonEntity, ElectricArtilleryWagonItem,
	{
		type = "recipe",
		name = "james-electric-cargo-wagon",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{"cargo-wagon", 1},
			{"electric-engine-unit", 8},
			{"copper-cable", 30},
			{"electronic-circuit", 10},
		},
		results = {{"james-electric-cargo-wagon",1}},
	},
	{
		type = "recipe",
		name = "james-electric-fluid-wagon",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{"fluid-wagon", 1},
			{"electric-engine-unit", 8},
			{"copper-cable", 30},
			{"electronic-circuit", 10},
		},
		results = {{"james-electric-fluid-wagon",1}},
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
				recipe = "james-electric-cargo-wagon"
			},
			{
				type = "unlock-recipe",
				recipe = "james-electric-fluid-wagon"
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