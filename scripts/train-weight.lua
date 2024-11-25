--Initialization Function
local function OnInit()
	storage.JamesWeightyTrains = { }
end

--Function to fetch values from the master table
local function ReadMasterTable() --1 is the train, 2 is the rolling stock weight, 3 is the variable weight

end

--Function to determine train rolling stock weight
local function TrainStockWeight(Train)
	return Train.weight
end

--Function to determine train cargo weight
local function TrainVariableWeight(Train)
	local TrainCargoWeight = 0
	Train.get_contents()
	Train.get_fluid_contents()
	return TrainCargoWeight
end

--Function to determine train state update, and take appropriate action
local function UpdateTrainState(event)
	local UpdateTrain = event.train
	local PrevState = event.old_state
	if PrevState == wait_station then --If the train was previously waiting at a station, it's variable weight likely changed
		
	end
end

script.on_init(OnInit)
script.on_event(defines.events.on_train_changed_state, UpdateTrainState)