local Objective = {
    name = "",
    isCompleted = false
}

function Objective:new(o, name)
    o = o or { }
    setmetatable(o, self)
    self.__index = self

    o.name = name or "[Unamed Objective]"
    o.isCompleted = false

    if o.Evaluate == nil then
        --error("Objective \"".. o.name .."\" requires an \"Evaluate\" function!")
    end

    return o
end

function Objective:OnCompleted()
    print(self.name .." completed :)")
end

return Objective