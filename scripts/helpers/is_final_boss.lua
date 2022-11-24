local finalBossesTypes = {
    EntityType.ENTITY_MOM,
    EntityType.ENTITY_MOMS_HEART,
    EntityType.ENTITY_ISAAC,
    EntityType.ENTITY_SATAN,
    EntityType.ENTITY_THE_LAMB,
    EntityType.ENTITY_MEGA_SATAN,
    EntityType.ENTITY_MEGA_SATAN_2,
    EntityType.ENTITY_ULTRA_GREED,
    EntityType.ENTITY_HUSH,
    EntityType.ENTITY_DELIRIUM,
    EntityType.ENTITY_MOTHER,
    EntityType.ENTITY_DOGMA,
    EntityType.ENTITY_BEAST
}

return function(entity)
    if entity == nil then
        return false
    end

    for _, finalBossType in ipairs(finalBossesTypes) do
        if entity.Type == finalBossType then
            return true
        end
    end

    return false
end