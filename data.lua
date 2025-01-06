require("__LSlib_James_Fork__/LSlib")
require("prototypes/item-groups")

Modname = "__James-Train-Mod__"

data.raw.locomotive["locomotive"].max_power = "500kW"
data.raw.locomotive["locomotive"].max_speed = 0.3
data.raw["item-with-entity-data"]["locomotive"].icons = {
	{
		icon = "__base__/graphics/icons/locomotive.png",
		scale = 2
	},
	{
		icon = "__base__/graphics/icons/tooltips/tooltip-category-chemical.png",
		icon_size = 32,
		scale = 2,
		icon_mipmaps = 2,
	},
}

