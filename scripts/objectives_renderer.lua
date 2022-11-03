local ObjectivesRenderer = { }

local objectivesToRender = { }

local function GetScreenSize()
    local room = Game():GetRoom()
    local pos = room:WorldToScreenPosition(Vector(0,0)) - room:GetRenderScrollOffset() - Game().ScreenShakeOffset
    
    local rx = pos.X + 60 * 26 / 40
    local ry = pos.Y + 140 * (26 / 40)
    
    return Vector(rx*2 + 13*26, ry*2 + 7*26)
end
local function GetScreenCenter()
    return GetScreenSize()/2
end

function ObjectivesRenderer:ClearObjectiveToRender(objective)
    objectivesToRender = { }
end

function ObjectivesRenderer:AddObjectiveToRender(objective)
    table.insert(objectivesToRender, objective)
end

-- MC_POST_RENDER --
function ObjectivesRenderer:OnRender()
    local screenSize = GetScreenSize()
    local hudOffset = Options.HUDOffset * Vector(20, 12)
    local customOffset = Vector(30, 30)
    local objectiveIndividualOffset = Vector(10, 0)
    for i, objective in ipairs(objectivesToRender) do
        objective.sprite:Render(screenSize - hudOffset - customOffset - objectiveIndividualOffset*i)
    end
end

return ObjectivesRenderer