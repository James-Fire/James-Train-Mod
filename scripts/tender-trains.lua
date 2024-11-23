--Initialization Function
local function OnInit()
	storage.JamesTenderTrains = { }
end

local function on_new_train(event)
	local NewTrain = event.train
	if not NewTrain then return end
	table.insert(storage.JamesTenderTrains, NewTrain)
end

script.on_event(defines.events.on_tick, function(event)
	--game.print("pre tick")
	storage.JECounter = storage.JECounter + 1
	if (storage.JECounter == 60) then
		UpdateTrains()
		storage.JECounter = 0
		--game.print("tick")
	end
end)

script.on_init(OnInit)
script.on_event(defines.events.on_train_created, on_new_train)