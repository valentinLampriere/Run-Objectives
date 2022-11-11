local AngelsDeceiverObjective = { }

AngelsDeceiverObjective.Stats = {
    AngelsKillAmount = 4
}

local objective = RunObjectivesAPI.Objective:new(AngelsDeceiverObjective, "Angels Deceiver")

local killedAngelsCount = 0

function AngelsDeceiverObjective:Evaluate()
    return killedAngelsCount >= AngelsDeceiverObjective.Stats.AngelsKillAmount
end

function AngelsDeceiverObjective:OnCompleted()
end

function AngelsDeceiverObjective:OnNewRun(IsContinued)
    killedAngelsCount = 0
end

RunObjectivesAPI:RegisterObjective(objective)

function AngelsDeceiverObjective:OnAngelKilled(entity)
    if entity.SubType ~= 0 then
        return
    end

    killedAngelsCount = killedAngelsCount + 1
end

RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_POST_ENTITY_KILL, AngelsDeceiverObjective.OnAngelKilled, EntityType.ENTITY_URIEL)
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_POST_ENTITY_KILL, AngelsDeceiverObjective.OnAngelKilled, EntityType.ENTITY_GABRIEL)