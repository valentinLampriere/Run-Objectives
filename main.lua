if REPENTANCE == nil then
    print("/!\\\"Run Objectives\" will only work with REPENTANCE")
    return
end

-- Register the mod.
local RunObjectivesMod = RegisterMod("Run Objectives", 1)

-- Include modules.
local Objective = include("scripts.objective")
local ObjectivesRenderer = include("scripts.objectives_renderer")
local ObjectiveCompletedRenderer = include("scripts.objective_completed_renderer")


-- Fields
local registeredObjectives = { }

-- Functions
function RunObjectivesMod:RegisterObjective(objective)
    if objective.Evaluate == nil then
        error("Objective \"".. objective.name .."\" requires an \"Evaluate\" function!")
    end

    table.insert(registeredObjectives, objective)
end

-- MC_POST_UPDATE --
function RunObjectivesMod:OnUpdate()
    for i, objective in ipairs(registeredObjectives) do
        if objective.isCompleted == false and objective:Evaluate() == true then
            objective:OnCompleted()
            objective.isCompleted = true
            ObjectivesRenderer:AddObjectiveToRender(objective)
            ObjectiveCompletedRenderer:RequestRenderNewCompletedObjective(objective)
        end
    end
end

-- MC_POST_GAME_STARTED --
function RunObjectivesMod:OnGameStart(isContinued)
    for i, registeredObjective in ipairs(registeredObjectives) do
        registeredObjective.isCompleted = false
        registeredObjective:OnNewRun(isContinued)
    end
    ObjectivesRenderer:ClearObjectiveToRender()
end

RunObjectivesMod:AddCallback(ModCallbacks.MC_POST_UPDATE, RunObjectivesMod.OnUpdate)
RunObjectivesMod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, RunObjectivesMod.OnGameStart)
RunObjectivesMod:AddCallback(ModCallbacks.MC_POST_RENDER, ObjectivesRenderer.OnRender)

-- API --
function RunObjectivesMod:AddObjectiveCallback(objective, isCompleted, modCallbacks, functionCallback, ...)
    RunObjectivesMod:AddCallback(modCallbacks, function (...)
        if objective.isCompleted == isCompleted then
            return functionCallback(...)
        end
    end, ...)
end

RunObjectivesAPI = { }
RunObjectivesAPI.Objective = Objective
RunObjectivesAPI.RegisterObjective = RunObjectivesMod.RegisterObjective
RunObjectivesAPI.AddObjectiveCallback = RunObjectivesMod.AddObjectiveCallback
-- API --

include("scripts.Objectives.quality_four_reroller")
include("scripts.Objectives.gets_three_knives")
include("scripts.Objectives.angels_deceiver")