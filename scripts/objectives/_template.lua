local NewObjective = { }

NewObjective.Stats = {
    
}

local objective = RunObjectivesAPI.Objective:New(NewObjective, "")


function NewObjective:Evaluate()
    return false
end

function NewObjective:OnCompleted()
    
end

function NewObjective:OnNewRun(IsContinued)

end

-- Callbacks --
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_POST_UPDATE, function() end)