--Hidden Accumulator and power pole
local Accumulator = table.deepcopy(data.raw["accumulator"]["accumulator"])
	Accumulator.name = "james-rail-accumulator"
	Accumulator.collision_mask = {"not-colliding-with-itself"}
	Accumulator.flags = {"not-on-map","placeable-off-grid","not-blueprintable","not-deconstructable"}
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
	StraightPoweredRailEntity.minable = {mining_time = 0.5, result = "james-powered-rail"},
	
local CurvedPoweredRailEntity = table.deepcopy(data.raw["curved-rail"]["curved-rail"])
	CurvedPoweredRailEntity.name = "james-powered-rail-curved"
	StraightPoweredRailEntity.minable = {mining_time = 0.5, result = "james-powered-rail", count = 4},
	
local PoweredRailItem = table.deepcopy(data.raw["rail-planner"]["rail"])
	PoweredRailItem.name = "james-powered-rail"
    PoweredRailItem.straight_rail = "james-powered-rail"
    PoweredRailItem.curved_rail = "james-powered-rail-curved"

--Train(s)
local ElectricTrainEntity = table.deepcopy(data.raw["locomotive"]["locomotive"])
	ElectricTrainEntity.burner.fuel_inventory_size = 0
	ElectricTrainEntity.burner.smoke = nil
	
local ElectricTrainItem = table.deepcopy(data.raw["item-with-entity-data"]["locomotive"])

if settings.startup["train-tiers"].value then
	if settings.startup["electric-train-upgrade"].value then
	
	end
end

--Data extend everything, and make our hidden item
data:extend({Accumulator,
StraightPoweredRailEntity, CurvedPoweredRailEntity, PoweredRailItem,
ElectricTrainEntity, ElectricTrainItem
	{
		type = "recipe",
		name = "james-powered-rail",
		enabled = false,
		energy_required = 1,
		ingredients = { {"rail", 1}, {"copper-cable", 5} },
		results = {{"james-powered-rail",1}},
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