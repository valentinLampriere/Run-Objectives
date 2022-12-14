local Objective = {
    name = "",
    isCompleted = false,
    gfx = "gfx/objectivesIcons/qualityFourReroller.png",
    sprite = nil
}

function Objective:New(o, name)
    o = o or { }
    setmetatable(o, self)
    self.__index = self

    o.name = name or "[Unamed Objective]"
    o.isCompleted = false

    local sprite = Sprite()
	sprite:Load("gfx/objectiveIcon.anm2", true)
    sprite:Play(sprite:GetDefaultAnimation(), true)
    sprite:ReplaceSpritesheet(0, o.gfx)
    o.sprite = sprite

    RunObjectivesAPI:RegisterObjective(o)

    return o
end

function Objective:Evaluate()
    return false
end

function Objective:OnCompleted()
end

function Objective:OnNewRun(isContinued)
end

return Objective