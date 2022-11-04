local RenderHelper = include("scripts.render_helper")

local ObjectivesRenderer = { }

local objectivesToRender = { }

function ObjectivesRenderer:ClearObjectiveToRender(objective)
    objectivesToRender = { }
end

function ObjectivesRenderer:AddObjectiveToRender(objective)
    table.insert(objectivesToRender, objective)
end

-- MC_POST_RENDER --
function ObjectivesRenderer:OnRender()
    local screenSize = RenderHelper:GetScreenSize()
    local hudOffset = RenderHelper:GetHUDOffset()
    local customOffset = Vector(30, 30)
    local objectiveIndividualOffset = Vector(10, 0)
    for i, objective in ipairs(objectivesToRender) do
        objective.sprite:Render(screenSize - hudOffset - customOffset - objectiveIndividualOffset*i)
    end
end

return ObjectivesRenderer