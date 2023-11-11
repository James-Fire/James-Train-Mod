--[[if settings.startup["variable-weighty-trains"].value then
	require("scripts/train-weight")
end]]
if settings.startup["powered-rails"].value then
	require("scripts/powered-rails")
end
if settings.startup["tender-trains"].value then
	require("scripts/tender-trains")
end