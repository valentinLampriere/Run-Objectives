local RenderHelper = include("scripts.render_helper")

local ObjectiveCompletedRenderer = { }

local requestRenderNewCompletedObjective = false
local lastCompletedObjective = nil

local font = Font()
font:Load("font/teammeatfont10")

local fontColor = KColor(0, 0, 0, 1, 0, 0, 0)

local fortunePaper = Sprite()
fortunePaper:Load("gfx/ui/ui_fortunepaper.anm2", true)

function ObjectiveCompletedRenderer:RequestRenderNewCompletedObjective(objective)
    lastCompletedObjective = objective
    requestRenderNewCompletedObjective = true

    fortunePaper:Play("Text", true)
end

-- MC_POST_RENDER --
function ObjectiveCompletedRenderer:OnRender()
    if requestRenderNewCompletedObjective == false then
        return
    end

    local screenCenter = RenderHelper:GetScreenCenter()

    font:DrawString(lastCompletedObjective.name, screenCenter.X, screenCenter.Y, fontColor, 0, true)
    fortunePaper:Render(screenCenter)
end

return ObjectiveCompletedRenderer