--Initialization Function
local function OnInit()
	storage.JamesWeightyTrains = { }
end

--Function to fetch values from the master table
local function ReadMasterTable(TrainID, Entry) --1 is the train, 2 is the rolling stock weight, 3 is the variable weight
	if Entry then
		return storage.JamesWeightyTrains[TrainID][Entry]
	else
		return storage.JamesWeightyTrains[TrainID]
	end
end

--Function to determine train cargo weight
local function TrainVariableWeight(Train)
	local TrainCargoWeight = 0
	for i, itemstack in pairs(Train.get_contents()) do
		if prototypes.item[itemstack.name].weight then --If the item has a weight defined, use it.
			TrainCargoWeight = TrainCargoWeight + itemstack.count * prototypes.item[itemstack.name].weight
		else --If the item doesn't have a weight defined, use the standard weight for a stack
			TrainCargoWeight = TrainCargoWeight + itemstack.count / prototypes.item[itemstack.name].stack_size * 10
		end
	end
	for i, fluid in pairs(Train.get_fluid_contents()) do
		--Fluids don't have anything on them that could possibly be used to infer a weight
		--and I don't feel like manually adding weight support for every fluid
		--so I guess we just assume they're all the same density?
		--But also fluids are heavy, about 1 4/6 x that of items
		TrainCargoWeight = TrainCargoWeight + fluid * 0.25
	end
	return TrainCargoWeight
end

local function UpdateTrainWeight(Train, CurrentWeight)
	local NewWeight = storage.JamesWeightyTrains[Train][3]
	
end

--Function to determine train state update, and take appropriate action
local function UpdateTrainState(event)
	local UpdateTrain = event.train
	local PrevState = event.old_state
	if PrevState == wait_station or PrevState == manual_control then --If the train was previously waiting at a station, or was previously manual, it's variable weight likely changed
		if storage.JamesWeightyTrains[UpdateTrain] then
			if storage.JamesWeightyTrains[UpdateTrain][3] == TrainVariableWeight(Train) then
				break
			else
				local CurrentWeight = storage.JamesWeightyTrains[UpdateTrain][3]
				storage.JamesWeightyTrains[UpdateTrain][3] = TrainVariableWeight(Train)
				UpdateTrainWeight(Train, CurrentWeight)
			end
		end
	end
end

script.on_init(OnInit)
script.on_event(defines.events.on_train_changed_state, UpdateTrainState)