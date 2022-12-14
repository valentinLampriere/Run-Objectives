local SkullCrusherObjective = { }

SkullCrusherObjective.Stats = {
    RequiredDestroyedSkull = 2
}

local objective = RunObjectivesAPI.Objective:New(SkullCrusherObjective, "Skull Crusher")

local game = Game()
local room = nil
local level = nil
local gridElementsState = { }

local skullDestroyedAmount = 0

function SkullCrusherObjective:Evaluate()
    return skullDestroyedAmount >= SkullCrusherObjective.Stats.RequiredDestroyedSkull
end

function SkullCrusherObjective:OnNewRun(IsContinued)
    gridElementsState = { }
    skullDestroyedAmount = 0
end

function SkullCrusherObjective:OnNewRoom()
    room = game:GetRoom()
    level = game:GetLevel()

    gridElementsState = { }
end

function SkullCrusherObjective:OnUpdate()
    local levelStage = level:GetStage()
    if levelStage ~= LevelStage.STAGE3_1 and levelStage ~= LevelStage.STAGE3_2 then
        return
    end

    for i = 0, room:GetGridSize() do
        local grid = room:GetGridEntity(i)
        if grid ~= nil then
            local gridEntityRock = grid:ToRock()
            local gridType = grid:GetType()
            if gridEntityRock ~= nil and gridType == GridEntityType.GRID_ROCK_ALT then
                if gridEntityRock.State == 2 and gridElementsState[gridEntityRock:GetGridIndex()] ~= gridEntityRock.State then
                    skullDestroyedAmount = skullDestroyedAmount + 1
                    gridElementsState[gridEntityRock:GetGridIndex()] = gridEntityRock.State
                end
            end
        end
    end
end

-- Callbacks --
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_POST_NEW_ROOM, SkullCrusherObjective.OnNewRoom)
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_POST_UPDATE, SkullCrusherObjective.OnUpdate)