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
--[[if settings.startup["variable-weighty-trains"].value then
	require("prototypes/train-weight")
end]]
