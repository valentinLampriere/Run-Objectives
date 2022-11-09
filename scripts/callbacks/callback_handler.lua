local CallbackHandler = {
    ID = -1,
    DefaultArgument = { },
    RegisteredCallbacks = { }
}

function CallbackHandler:new(o, id, defaultArgument)
    o = o or { }
    setmetatable(o, self)
    self.__index = self

    o.ID = id
    o.DefaultArgument = defaultArgument or { }
    o.RegisteredCallbacks = o.RegisteredCallbacks or { }

    return o
end

function CallbackHandler:AddCallback(_function, ...)
    local args = {...}

	if _function == nil then
		return
	end

	local arguments = { }

	for i = 1, #args do
		table.insert(arguments, args[i] or self.DefaultArgument[i])
	end
	for i = #args + 1, #self.DefaultArgument do
		table.insert(arguments, self.DefaultArgument[i])
	end
	
	table.insert(self.RegisteredCallbacks, {
		Function = _function,
		Argument = arguments
	})
end

return CallbackHandler