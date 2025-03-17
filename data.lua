require("__LSlib_James_Fork__/LSlib")
require("prototypes/item-groups")

Modname = "__James-Train-Mod__"

data.raw["item-with-entity-data"]["locomotive"].icons = {
	{
		icon = "__base__/graphics/icons/locomotive.png",
		scale = 0.5
	},
	{
		icon = "__base__/graphics/icons/tooltips/tooltip-category-chemical.png",
		icon_size = 32,
		scale = 0.5,
		shift = {8, -12},
		icon_mipmaps = 2,
	},
}

if settings.startup["train-tiers"].value then
	data.raw.locomotive["locomotive"].max_power = "500kW"
	data.raw.locomotive["locomotive"].max_speed = 0.6
	require("prototypes/train-tiers")
end
if settings.startup["train-car-tiers"].value then
	require("prototypes/train-car-tiers")
end
if settings.startup["hybrid-trains"].value then
	require("prototypes/hybrid-trains")
end
if settings.startup["electric-trains"].value then
	require("prototypes/electric-trains")
end
if settings.startup["nuclear-trains"].value and settings.startup["hybrid-trains"].value then
	require("prototypes/nuclear-hybrid-trains")
end
if settings.startup["nuclear-trains"].value then
	require("prototypes/nuclear-trains")
end
if settings.startup["electric-train-cars"].value then
	require("prototypes/electric-train-cars")
end
if settings.startup["powered-rails"].value then
	require("prototypes/powered-rails")
end
--[[if settings.startup["variable-weighty-trains"].value then
	require("prototypes/train-weight")
end]]
