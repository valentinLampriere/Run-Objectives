local ObjectiveCompletedRenderer = { }

-- TODO : Render also an icon.

local subtitleText = "New objective completed!"

local hud = Game():GetHUD()

function ObjectiveCompletedRenderer:RequestRenderNewCompletedObjective(objective)
    hud:ShowItemText(objective.name, subtitleText)
end

return ObjectiveCompletedRenderer