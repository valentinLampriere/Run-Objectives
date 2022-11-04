local RenderHelper = { }

function RenderHelper:GetScreenSize()
    local room = Game():GetRoom()
    local pos = room:WorldToScreenPosition(Vector(0,0)) - room:GetRenderScrollOffset() - Game().ScreenShakeOffset
    
    local rx = pos.X + 60 * 26 / 40
    local ry = pos.Y + 140 * (26 / 40)
    
    return Vector(rx*2 + 13*26, ry*2 + 7*26)
end

function RenderHelper:GetScreenCenter()
    return RenderHelper:GetScreenSize()/2
end

function RenderHelper:GetHUDOffset()
    return Options.HUDOffset * Vector(20, 12)
end

return RenderHelper;