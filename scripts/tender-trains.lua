--Initialization Function
local function OnInit()
	global.JamesTenderTrains = { }
end

local function on_new_train(event)
	local NewTrain = event.train
	if not NewTrain then return end
	table.insert(global.JamesTenderTrains, NewTrain)
end

script.on_event(defines.events.on_tick, function(event)
	--game.print("pre tick")
	global.JECounter = global.JECounter + 1
	if (global.JECounter == 60) then
		UpdateTrains()
		global.JECounter = 0
		--game.print("tick")
	end
end)

script.on_init(OnInit)
script.on_event(defines.events.on_train_created, on_new_train)