local NewObjective = { }

NewObjective.Stats = {
    
}

local objective = RunObjectivesAPI.Objective:new(NewObjective, "")


function NewObjective:Evaluate()
    return false
end

function NewObjective:OnCompleted()
    
end

function NewObjective:OnNewRun(isCompleted)

end

RunObjectivesAPI:RegisterObjective(objective)

-- Callbacks --
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_POST_UPDATE, function() end)