--Hidden Accumulator and power pole
local PowerPoleSignalEntity = table.deepcopy(data.raw["rail-signal"]["rail-signal"])
	PowerPoleSignalEntity.name = "james-rail-signal"
	PowerPoleSignalEntity.minable = {mining_time = 0.2, result = "james-rail-signal"}
    PowerPoleSignalEntity.icons = {
		{
			icon = "__base__/graphics/icons/rail.png",
			icon_size = 64,
			icon_mipmaps = 4,
		},
		{
			icon = "__base__/graphics/icons/medium-electric-pole.png",
			icon_size = 64,
			scale = 1 / 2,
			shift = {0, 0},
			icon_mipmaps = 4,
		},
	}
	
local PowerPoleSignalItem = table.deepcopy(data.raw.item["rail-signal"])
	PowerPoleSignalItem.name = "james-rail-signal"
	PowerPoleSignalItem.place_result = "james-rail-signal"
    PowerPoleSignalItem.icons = {
		{
			icon = "__base__/graphics/icons/rail.png",
			icon_size = 64,
			icon_mipmaps = 4,
		},
		{
			icon = "__base__/graphics/icons/medium-electric-pole.png",
			icon_size = 64,
			scale = 1 / 2,
			shift = {0, 0},
			icon_mipmaps = 4,
		},
	}
	
local SignalPowerPole = table.deepcopy(data.raw["electric-pole"]["small-electric-pole"])
	SignalPowerPole.name = "james-rail-pole"
    SignalPowerPole.supply_area_distance = 1
	SignalPowerPole.placeable_by = {item=PowerPoleSignalItem.name, count=1}
    SignalPowerPole.flags = {"not-on-map","placeable-off-grid"}
	SignalPowerPole.minable = {mining_time = 0.2, result = "james-rail-signal"}
	SignalPowerPole.connection_points = {
      {
        shadow =
        {
           copper = nil,
          green = nil,
          red = nil
        },
        wire =
        {
          copper = {0, -2},
          green = {0, -2},
          red = {0, -2}
        }
      },
      {
        shadow =
        {
           copper = nil,
          green = nil,
          red = nil
        },
        wire =
        {
          copper = {0, -2},
          green = {0, -2},
          red = {0, -2}
        }
      },
      {
        shadow =
        {
           copper = nil,
          green = nil,
          red = nil
        },
        wire =
        {
          copper = {0, -2},
          green = {0, -2},
          red = {0, -2}
        }
      },
      {
        shadow =
        {
           copper = nil,
          green = nil,
          red = nil
        },
        wire =
        {
          copper = {0, -2},
          green = {0, -2},
          red = {0, -2}
        }
      },
    }
	
local PowerPole = table.deepcopy(SignalPowerPole)
	PowerPole.name = "james-track-pole"
	PowerPole.selection_box = nil --{{-0.1, -0.1}, {0.1, 0.1}}
	PowerPole.collision_box = {{0, 0}, {0, 0}}
	PowerPole.collision_mask = {"not-colliding-with-itself"}
	PowerPole.icon = "__core__/graphics/empty.png"
    PowerPole.icon_size = 1
    PowerPole.minable= nil
	PowerPole.draw_circuit_wires=false
	PowerPole.selectable_in_game=false
    PowerPole.supply_area_distance = 0.5
    PowerPole.maximum_wire_distance = 9
    PowerPole.pictures.layers = {
        {
			filename = "__core__/graphics/empty.png",
			priority = "extra-high",
			width = 1,
			height = 1,
			direction_count = 1,
			shift = util.by_pixel(2, -42),
			hr_version = {
				filename = "__core__/graphics/empty.png",
				priority = "extra-high",
				width = 1,
				height = 1,
				direction_count = 1,
				shift = util.by_pixel(2, -42),
			}
        },
	}
    PowerPole.water_reflection.layers = {
        {
			filename = "__core__/graphics/empty.png",
			priority = "extra-high",
			width = 1,
			height = 1,
			direction_count = 1,
			shift = util.by_pixel(2, -42),
			hr_version = {
				filename = "__core__/graphics/empty.png",
				priority = "extra-high",
				width = 1,
				height = 1,
				direction_count = 1,
				shift = util.by_pixel(2, -42),
			}
        },
	}
	PowerPole.connection_points = {
      {
        shadow =
        {
           copper = nil,
          green = nil,
          red = nil
        },
        wire =
        {
          copper = {0, 0},
          green = {0, 0},
          red = {0, 0}
        }
      },
	}
    PowerPole.flags = {"not-on-map","placeable-off-grid","not-blueprintable","not-deconstructable"}
	
local Accumulator = table.deepcopy(data.raw["accumulator"]["accumulator"])
	Accumulator.name = "james-rail-accumulator"
	Accumulator.selection_box = nil --{{-0.1, -0.1}, {0.1, 0.1}}
	Accumulator.collision_box = {{0, 0}, {0, 0}}
	Accumulator.collision_mask = {"not-colliding-with-itself"}
	Accumulator.flags = {"not-on-map","placeable-off-grid","not-blueprintable","not-deconstructable"}
	Accumulator.next_upgrade = nil
	Accumulator.icon = "__base__/graphics/icons/locomotive.png"
    Accumulator.icon_size = 64
    Accumulator.picture.layers = {
        {
			filename = "__core__/graphics/empty.png",
			priority = "extra-high",
			width = 1,
			height = 1,
			direction_count = 1,
			shift = util.by_pixel(2, -42),
			hr_version = {
				filename = "__core__/graphics/empty.png",
				priority = "extra-high",
				width = 1,
				height = 1,
				direction_count = 1,
				shift = util.by_pixel(2, -42),
			}
        },
	}
    Accumulator.charge_animation.layers = {
        {
			filename = "__core__/graphics/empty.png",
			priority = "extra-high",
			width = 1,
			height = 1,
			direction_count = 1,
			shift = util.by_pixel(2, -42),
			hr_version = {
				filename = "__core__/graphics/empty.png",
				priority = "extra-high",
				width = 1,
				height = 1,
				direction_count = 1,
				shift = util.by_pixel(2, -42),
			}
        },
	}
    Accumulator.discharge_animation.layers = {
        {
			filename = "__core__/graphics/empty.png",
			priority = "extra-high",
			width = 1,
			height = 1,
			direction_count = 1,
			shift = util.by_pixel(2, -42),
			hr_version = {
				filename = "__core__/graphics/empty.png",
				priority = "extra-high",
				width = 1,
				height = 1,
				direction_count = 1,
				shift = util.by_pixel(2, -42),
			}
        },
	}
    Accumulator.water_reflection.layers = {
        {
			filename = "__core__/graphics/empty.png",
			priority = "extra-high",
			width = 1,
			height = 1,
			direction_count = 1,
			shift = util.by_pixel(2, -42),
			hr_version = {
				filename = "__core__/graphics/empty.png",
				priority = "extra-high",
				width = 1,
				height = 1,
				direction_count = 1,
				shift = util.by_pixel(2, -42),
			}
        },
	}
	Accumulator.energy_source = {
      type = "electric",
      buffer_capacity = "10MJ",
      usage_priority = "primary-input",
      input_flow_limit = "10MW",
      output_flow_limit = "0MW",
	  drain = "1kW"
    }
	
--Rails
local StraightPoweredRailEntity = table.deepcopy(data.raw["straight-rail"]["straight-rail"])
	StraightPoweredRailEntity.name = "james-powered-rail"
	StraightPoweredRailEntity.minable = {mining_time = 0.5, result = "james-powered-rail"}
	StraightPoweredRailEntity.fast_replaceable_group = "space-rail"
    StraightPoweredRailEntity.icons = {
		{
			icon = "__base__/graphics/icons/rail.png",
			icon_size = 64,
			icon_mipmaps = 4,
		},
		{
			icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
			icon_size = 32,
			scale = 1 / 2,
			shift = {0, 0},
		},
	}
	
local CurvedPoweredRailEntity = table.deepcopy(data.raw["curved-rail"]["curved-rail"])
	CurvedPoweredRailEntity.name = "james-powered-rail-curved"
	CurvedPoweredRailEntity.minable = {mining_time = 0.5, result = "james-powered-rail", count = 4}
	CurvedPoweredRailEntity.placeable_by = {item = "james-powered-rail", count = 4}
	CurvedPoweredRailEntity.fast_replaceable_group = "space-rail-curved"
    CurvedPoweredRailEntity.icons = {
		{
			icon = "__base__/graphics/icons/rail.png",
			icon_size = 64,
			icon_mipmaps = 4,
		},
		{
			icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
			icon_size = 32,
			scale = 1 / 2,
			shift = {0, 0},
		},
	}
	
local PoweredRailItem = table.deepcopy(data.raw["rail-planner"]["rail"])
	PoweredRailItem.name = "james-powered-rail"
    PoweredRailItem.localised_name = {"item-name.james-powered-rail"}
	PoweredRailItem.place_result = "james-powered-rail"
    PoweredRailItem.straight_rail = "james-powered-rail"
    PoweredRailItem.curved_rail = "james-powered-rail-curved"
    PoweredRailItem.icons = {
		{
			icon = "__base__/graphics/icons/rail.png",
			icon_size = 64,
			icon_mipmaps = 4,
		},
		{
			icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
			icon_size = 32,
			scale = 1 / 2,
			shift = {0, 0},
		},
	}

data.raw["straight-rail"]["straight-rail"].fast_replaceable_group = "space-rail"
data.raw["curved-rail"]["curved-rail"].fast_replaceable_group = "space-rail-curved"
--Data extend everything, and make our hidden item
data:extend({PowerPoleSignalEntity, PowerPoleSignalItem, SignalPowerPole, PowerPole,
Accumulator, StraightPoweredRailEntity, CurvedPoweredRailEntity, PoweredRailItem,
	{
		type = "recipe",
		name = "james-rail-signal",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{"medium-electric-pole", 1},
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
		icons = {
			{
				icon = "__base__/graphics/icons/rail.png",
				icon_size = 64,
				icon_mipmaps = 4,
			},
			{
				icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
				icon_size = 32,
				shift = {0, 0},
			},
		},
		prerequisites = {"railway", "production-science-pack"},
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