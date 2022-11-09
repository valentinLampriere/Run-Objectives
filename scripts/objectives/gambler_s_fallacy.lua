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

function GambersFallacyObjective:OnMachineUpdate(machine)
    print("Machine update :)")
end

-- Callbacks --
RunObjectivesAPI:AddObjectiveCallback(objective, false, RunObjectivesAPI.ModCallbacks.MACHINE_UPDATE, GambersFallacyObjective.OnMachineUpdate)