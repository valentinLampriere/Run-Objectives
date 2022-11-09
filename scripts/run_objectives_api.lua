local RunObjectivesAPI = { }

RunObjectivesAPI.modCallbacksOffset = 1 << 7

RunObjectivesAPI.ModCallbacks = {
    MACHINE_UPDATE = 1 + RunObjectivesAPI.modCallbacksOffset
}

return RunObjectivesAPI