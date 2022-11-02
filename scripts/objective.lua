local Objective = {
    name = "",
    isCompleted = false
}

function Objective:new(o, name)
    o = o or { }
    setmetatable(o, self)
    self.__index = self

    self.name = name or "???"
    self.isCompleted = false

    return o
end

function Objective:Evaluate()
    return false
end

function Objective:OnCompleted()
    print(self.name .." completed :)")
end

return Objective