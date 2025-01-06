local function blank_picture(tint, repeat_count)
  return
  {
    layers =
    {
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
  }
end

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
	PowerPole.collision_box = nil --{{0, 0}, {0.5, 0.5}}
	PowerPole.collision_mask = {layers={}, not_colliding_with_itself=true}
	PowerPole.icon = "__core__/graphics/empty.png"
    PowerPole.icon_size = 1
    PowerPole.minable= nil
	PowerPole.draw_copper_wires=false
	PowerPole.draw_circuit_wires=false
    PowerPole.supply_area_distance = 0.5
    PowerPole.maximum_wire_distance = 0
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
	
if settings.startup["powered-rails-diff"].value:find("copper-wire", 1, true) then
	PowerPole.draw_copper_wires=true
end
local Accumulator = table.deepcopy(data.raw["accumulator"]["accumulator"])
	Accumulator.name = "james-rail-accumulator"
	Accumulator.selection_box = nil --{{-0.1, -0.1}, {0.1, 0.1}}
	Accumulator.collision_box = nil --{{0, 0}, {0.5, 0.5}}
	Accumulator.collision_mask = --[[nil]] {layers={}, not_colliding_with_itself=true}
	Accumulator.flags = {"not-on-map","placeable-off-grid","not-blueprintable","not-deconstructable"}
	Accumulator.next_upgrade = nil
	Accumulator.icon = "__base__/graphics/icons/locomotive.png"
    Accumulator.icon_size = 64
    Accumulator.chargable_graphics.picture = blank_picture()
    Accumulator.chargable_graphics.charge_animation = blank_picture()
    Accumulator.chargable_graphics.discharge_animation = blank_picture()
	Accumulator.energy_source = {
      type = "electric",
      buffer_capacity = "10MJ",
      usage_priority = "primary-input",
      input_flow_limit = "10MW",
      output_flow_limit = "0MW",
	  drain = "1kW"
    }

LSlib.entity.MakePrototypeLightningImmune("james-track-pole")
LSlib.entity.MakePrototypeLightningImmune("james-rail-accumulator")
--Rails
local Rails = {
	"straight-rail",
	"half-diagonal-rail",
	"curved-rail-a",
	"curved-rail-b",
}
local RailsCount = {
	1,
	2,
	3,
	3,
}
if(mods["elevated-rails"]) then
	table.insert(Rails, "elevated-straight-rail")
	table.insert(RailsCount, 1)
	table.insert(Rails, "elevated-half-diagonal-rail")
	table.insert(RailsCount, 2)
	table.insert(Rails, "elevated-curved-rail-a")
	table.insert(RailsCount, 3)
	table.insert(Rails, "elevated-curved-rail-b")
	table.insert(RailsCount, 3)
	
local PoweredRailRamp = table.deepcopy(data.raw["rail-ramp"]["rail-ramp"])
PoweredRailRamp.name = "james-powered-rail-ramp"
PoweredRailRamp.minable = {mining_time = 0.2, result = "james-powered-rail-ramp"}
PoweredRailRamp.icons = {
	{
		icon = "__elevated-rails__/graphics/icons/rail-ramp.png",
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
data:extend({PoweredRailRamp})
--[[if settings.startup["powered-rails-diff"].value:find("electric-icon", 1, true) then
	table.insert(data.raw["rail-ramp"]["james-powered-rail-ramp"].pictures,
	{
		filename = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
		priority = "high",
		width = 32,
		height = 32,
		repeat_count = 1,
		--shift = util.by_pixel(0, -11),
		--tint = tint,
		--scale = 0.5
	})
end]]
LSlib.entity.MakePrototypeLightningImmune("james-powered-rail-ramp")
end

for i, rail in pairs(Rails) do
	local RailEntity = table.deepcopy(data.raw[rail][rail])
	RailEntity.name = "james-powered-rail-"..rail
	RailEntity.minable = {mining_time = 0.2, result = "james-powered-rail", count = RailsCount[i]}
	RailEntity.placeable_by = {item = "james-powered-rail", count = RailsCount[i]}
	RailEntity.localised_name = {"item-name.james-powered-rail"}
    RailEntity.icons = {
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
	LSlib.entity.MakePrototypeLightningImmune(RailEntity.name)
	data:extend({RailEntity})
end



local PoweredRailItem = table.deepcopy(data.raw["rail-planner"]["rail"])
PoweredRailItem.name = "james-powered-rail"
PoweredRailItem.localised_name = {"item-name.james-powered-rail"}
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
PoweredRailItem.place_result = "james-powered-rail-straight-rail"
PoweredRailItem.rails = 
    {
      "james-powered-rail-straight-rail",
      "james-powered-rail-curved-rail-a",
      "james-powered-rail-curved-rail-b",
      "james-powered-rail-half-diagonal-rail"
    }
if(mods["elevated-rails"]) then
	table.insert(PoweredRailItem.rails, "james-powered-rail-elevated-straight-rail")
	table.insert(PoweredRailItem.rails, "james-powered-rail-elevated-half-diagonal-rail")
	table.insert(PoweredRailItem.rails, "james-powered-rail-elevated-curved-rail-a")
	table.insert(PoweredRailItem.rails, "james-powered-rail-elevated-curved-rail-b")
local PoweredRailRampItem = table.deepcopy(data.raw["rail-planner"]["rail-ramp"])
PoweredRailRampItem.name = "james-powered-rail-ramp"
PoweredRailRampItem.icons = {
	{
		icon = "__elevated-rails__/graphics/icons/rail-ramp.png",
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
PoweredRailRampItem.place_result = "james-powered-rail-ramp"
PoweredRailRampItem.rails = PoweredRailItem.rails

data:extend({PoweredRailRampItem})
end


--data.raw["straight-rail"]["straight-rail"].fast_replaceable_group = "space-rail"
--data.raw["curved-rail"]["curved-rail"].fast_replaceable_group = "space-rail-curved"
--Data extend everything, and make our hidden item
data:extend({PowerPoleSignalEntity, PowerPoleSignalItem, SignalPowerPole, PowerPole,
Accumulator, PoweredRailItem, 
	{
		type = "recipe",
		name = "james-rail-signal",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{type = "item", name = "medium-electric-pole", amount = 1},
			{type = "item", name = "copper-cable", amount = 10}
		},
		results = {{type = "item", name = "james-rail-signal", amount = 1}},
	},
	{
		type = "recipe",
		name = "james-powered-rail",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{type = "item", name = "rail", amount = 1},
			{type = "item", name = "copper-cable", amount = 5}
		},
		results = {{type = "item", name = "james-powered-rail", amount = 1}},
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
    icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
    icon_size = 32,
    subgroup = "raw-resource",
	fuel_value = "100MJ",
    fuel_acceleration_multiplier = 2,
    fuel_top_speed_multiplier = 2,
	fuel_category = "electric-train",
    order = "a-a",
    stack_size = 50,
  },
})
if(mods["elevated-rails"]) then
data:extend({
	{
		type = "recipe",
		name = "james-powered-rail-ramp",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{type = "item", name = "refined-concrete", amount = 100},
			{type = "item", name = "rail", amount = 8},
			{type = "item", name = "steel-plate", amount = 10},
			{type = "item", name = "copper-cable", amount = 40}
		},
		results = {{type = "item", name = "james-powered-rail-ramp", amount = 1}},
	},
	{
		type = "recipe",
		name = "james-powered-rail-ramp-upgrade",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{type = "item", name = "rail-ramp", amount = 1},
			{type = "item", name = "copper-cable", amount = 40}
		},
		results = {{type = "item", name = "james-powered-rail-ramp", amount = 1}},
	},
	{
		type = "technology",
		name = "electrified-elevated-tracks",
		icons = {
			{
				icon = "__elevated-rails__/graphics/technology/elevated-rail.png",
				icon_size = 256,
			},
			{
				icon = "__core__/graphics/icons/tooltips/tooltip-category-electricity.png",
				scale = 4,
				icon_size = 32,
				shift = {0, 0},
			},
		},
		prerequisites = {"elevated-rail", "electrified-tracks"},
		effects = {
			{
				type = "unlock-recipe",
				recipe = "james-powered-rail-ramp"
			},
			{
				type = "unlock-recipe",
				recipe = "james-powered-rail-ramp-upgrade"
			},
		},
		unit = {
			count = 100,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{ "production-science-pack", 1 }
			},
			time = 30,
		},
		order = "d-a",
	},
})
end