local CallbackHandler = include("scripts.callbacks.callback_handler")

local PostMachineUpdateHandler = { }

-- Arguments :
-- 1 : Slot machine variant
-- 2 : is persitant ? (does the callback should be call when the machine is broken)
function PostMachineUpdateHandler:MC_POST_UPDATE()
    for _, callback in ipairs(PostMachineUpdateHandler.RegisteredCallbacks) do
        local machines = Isaac.FindByType(EntityType.ENTITY_SLOT, callback.Argument[1], -1, true, false)
        for _, machine in ipairs(machines) do
            local _mData = machine:GetData()
            if callback.Argument[2] == true or _mData.Sewn_isMachineBroken ~= true then
                callback:Function(machine)
            end
        end
    end
end

CallbackHandler:new(PostMachineUpdateHandler, RunObjectivesAPI.ModCallbacks.MACHINE_UPDATE, -1, false)

return PostMachineUpdateHandler