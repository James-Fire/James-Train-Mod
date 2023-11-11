--Initialization Function
local function OnInit()
	global.JamesWeightyTrains = { }
end

--Function to fetch values from the master table
local function ReadMasterTable() --1 is the train, 2 is the rolling stock weight, 3 is the variable weight

end

--Function to determine train rolling stock weight
local function TrainStockWeight(Train)

end

--Function to determine train cargo weight
local function TrainVariableWeight(Train)

end

--Function to determine train state update, and take appropriate action
local function UpdateTrainState(event)
	local UpdateTrain = event.train
	local PrevState = event.old_state
	if PrevState == wait_station then --If the train was previously waiting at a station, it's weight likely changed
		
	end
end

local function on_new_train(event)
	local NewTrain = event.train
	if not entity then return end
	local surface = entity.surface
	local position = entity.position
	local force = entity.force
	if TrainHasValidLocomotive(NewTrain) and CheckTableValue(NewTrain,global.JamesElectricTrains) == false then
		table.insert(global.JamesElectricTrains, NewTrain)
	--[[elseif WagonIsElectric and entity.train and CheckTableValue(entity.train,global.JamesElectricTrains) == false then
		table.insert(global.JamesElectricTrains, entity.train)]]
	end
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
script.on_event(defines.events.on_train_changed_state, UpdateTrainState)