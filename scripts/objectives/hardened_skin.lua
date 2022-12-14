local HardenedSkinObjective = { }

HardenedSkinObjective.Stats = {
    SelfDamageRequiredAmount = 5
}

local objective = RunObjectivesAPI.Objective:New(HardenedSkinObjective, "")

local selfDamageCount = 0

function HardenedSkinObjective:Evaluate()
    return selfDamageCount >= HardenedSkinObjective.Stats.SelfDamageRequiredAmount
end

function HardenedSkinObjective:OnNewRun(IsContinued)
    selfDamageCount = 0
end

function HardenedSkinObjective:OnPlayerTakeDamage(player, amount, damageFlags, source, countdown)
    if (source ~= nil and source.Entity ~= nil and GetPtrHash(source.Entity) == GetPtrHash(player)) or
        (source == nil or source.Entity == nil or source.Entity.Type == 0 and source.Entity.Variant == 0) then
        print("self damage")
    end
end

-- Callbacks --
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_ENTITY_TAKE_DMG, HardenedSkinObjective.OnPlayerTakeDamage, EntityType.ENTITY_PLAYER)