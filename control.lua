--[[if settings.startup["variable-weighty-trains"].value then
	require("scripts/train-weight")
end
if settings.startup["tender-trains"].value then
	require("scripts/tender-trains")
end]]
--Always required, the setting is checked inside. A conditional require makes the loaded
--script set differ between clients and breaks multiplayer with a mod mismatch error
require("scripts/powered-rails")