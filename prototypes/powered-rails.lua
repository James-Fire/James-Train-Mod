--Hidden Accumulator and power pole
local PowerPoleSignalEntity = table.deepcopy(data.raw["rail-signal"]["rail-signal"])
	PowerPoleSignalEntity.name = "james-rail-signal"
	
local PowerPoleSignalItem = table.deepcopy(data.raw.item["rail-signal"])
	PowerPoleSignalItem.name = "james-rail-signal"
	
local SignalPowerPole = table.deepcopy(data.raw["electric-pole"]["small-electric-pole"])
	SignalPowerPole.name = "james-rail-pole"
	SignalPowerPole.icon = "__core__/graphics/empty.png"
    SignalPowerPole.icon_size = 1
	
local PowerPole = table.deepcopy(data.raw["electric-pole"]["small-electric-pole"])
	PowerPole.name = "james-track-pole"
	
local Accumulator = table.deepcopy(data.raw["accumulator"]["accumulator"])
	Accumulator.name = "james-rail-accumulator"
	Accumulator.collision_mask = {"not-colliding-with-itself"}
	Accumulator.flags = {"not-on-map","placeable-off-grid","not-blueprintable","not-deconstructable"}
	Accumulator.icon = "__core__/graphics/empty.png"
    Accumulator.icon_size = 1
	Accumulator.energy_source = {
      type = "electric",
      buffer_capacity = "10MJ",
      usage_priority = "primary-input",
      input_flow_limit = "10MW",
      output_flow_limit = "0MW"
    }
	
--Rails
local StraightPoweredRailEntity = table.deepcopy(data.raw["straight-rail"]["straight-rail"])
	StraightPoweredRailEntity.name = "james-powered-rail"
	StraightPoweredRailEntity.minable = {mining_time = 0.5, result = "james-powered-rail"}
	
local CurvedPoweredRailEntity = table.deepcopy(data.raw["curved-rail"]["curved-rail"])
	CurvedPoweredRailEntity.name = "james-powered-rail-curved"
	CurvedPoweredRailEntity.minable = {mining_time = 0.5, result = "james-powered-rail", count = 4}
	CurvedPoweredRailEntity.placeable_by = {item = "james-powered-rail", count = 4}
	
local PoweredRailItem = table.deepcopy(data.raw["rail-planner"]["rail"])
	PoweredRailItem.name = "james-powered-rail"
    PoweredRailItem.localised_name = {"item-name.james-powered-rail"}
	PoweredRailItem.place_result = "james-powered-rail"
    PoweredRailItem.straight_rail = "james-powered-rail"
    PoweredRailItem.curved_rail = "james-powered-rail-curved"


--Data extend everything, and make our hidden item
data:extend({PowerPoleSignalEntity, PowerPoleSignalItem, SignalPowerPole, PowerPole,
Accumulator, StraightPoweredRailEntity, CurvedPoweredRailEntity, PoweredRailItem,
	{
		type = "recipe",
		name = "james-rail-signal",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{"medium-power-pole", 1},
			{"copper-cable", 10}
		},
		results = {{"james-rail-signal",1}},
	},
	{
		type = "recipe",
		name = "james-powered-rail",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{"rail", 1},
			{"copper-cable", 5}
		},
		results = {{"james-powered-rail",1}},
	},
	{
		type = "technology",
		name = "electrified-tracks",
		icon_size = 64,
		icon = "__base__/graphics/icons/steam-turbine.png",
		prerequisites = {"railway"},
		effects = {
			{
				type = "unlock-recipe",
				recipe = "james-powered-rail"
			},
			{
				type = "unlock-recipe",
				recipe = "james-rail-signal"
			},
		},
		unit = {
			count = 50,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
			},
			time = 30,
		},
		order = "d-a",
	},
	{
    type = "item",
    name = "electric-burner-item",
    icon = "__core__/graphics/empty.png",
    icon_size = 1,
    subgroup = "raw-resource",
	fuel_value = "100MJ",
	fuel_category = "chemical",
    order = "a-a",
    stack_size = 50,
  },
})