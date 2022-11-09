local GambersFallacyObjective = { }

GambersFallacyObjective.Stats = {
    RequiredCoinsToSpend = 100
}

local objective = RunObjectivesAPI.Objective:new(GambersFallacyObjective, "Gambler's Fallacy")


function GambersFallacyObjective:Evaluate()
    return false
end

function GambersFallacyObjective:OnCompleted()
    
end

function GambersFallacyObjective:OnNewRun(isCompleted)

end

RunObjectivesAPI:RegisterObjective(objective)

-- Callbacks --
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_POST_UPDATE, function() end)