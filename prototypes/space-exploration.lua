-- Space Exploration moves production and utility science far past the rocket, so the
-- powered rails would only unlock after space while the electric train stays on chemical.
-- This has to run in data-updates: SE's procedural pass in data-final-fixes stacks space
-- and rocket science on top of anything that still asks for production or utility science.
local SciencePacks = {
	"production-science-pack",
	"utility-science-pack",
}

-- Ground tracks belong next to the electric train, on chemical science.
for i, sciencePack in pairs(SciencePacks) do
	LSlib.technology.removeIngredient("electrified-tracks", sciencePack)
	LSlib.technology.removePrerequisite("electrified-tracks", sciencePack)
end

-- Elevated tracks follow elevated-rail, which SE moves to its own rocket science.
for i, sciencePack in pairs(SciencePacks) do
	LSlib.technology.removeIngredient("electrified-elevated-tracks", sciencePack)
	LSlib.technology.removePrerequisite("electrified-elevated-tracks", sciencePack)
end
LSlib.technology.addIngredient("electrified-elevated-tracks", 1, "se-rocket-science-pack")
