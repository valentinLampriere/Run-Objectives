if REPENTANCE == nil then
    print("/!\\\"Run Objectives\" will only work with REPENTANCE")
    return
end

-- Register the mod.
local RunObjectivesMod = RegisterMod("Run Objectives", 1)

-- Include modules.
local Objective = include("scripts.objective")

-- Fields
local registeredObjectives = { }

function RunObjectivesMod:RegisterObjective(objective)
    table.insert(registeredObjectives, objective)
end

function RunObjectivesMod:OnUpdate()
    for i, objective in ipairs(registeredObjectives) do
        if objective.isCompleted == false and objective:Evaluate() == true then
            objective:OnCompleted()
            objective.isCompleted = true
        end
    end
end

RunObjectivesMod:AddCallback(ModCallbacks.MC_POST_UPDATE, RunObjectivesMod.OnUpdate)


-- API
RunObjectivesAPI = { }
RunObjectivesAPI.Objective = Objective
RunObjectivesAPI.RegisterObjective = RunObjectivesMod.RegisterObjective






-- TEST
local TestObjective = { }

function TestObjective:Evaluate()
    return Game():GetFrameCount() > 60
end
function TestObjective:OnCompleted()
    Isaac.Spawn(5,100,4, Vector(320, 280), Vector.Zero, nil)
end

RunObjectivesMod:RegisterObjective(Objective:new(TestObjective))

include("scripts.Objectives.reroll_quality_four")