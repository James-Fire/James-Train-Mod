if settings.startup["train-tiers"].value then
	require("prototypes/train-tiers")
end
if settings.startup["train-car-tiers"].value then
	require("prototypes/train-car-tiers")
end
if settings.startup["electric-trains"].value and settings.startup["hybrid-trains"].value then
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