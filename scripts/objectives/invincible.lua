local InvincibleObjective = { }

InvincibleObjective.Stats = {
    RequiredDeath = 2
}

local objective = RunObjectivesAPI.Objective:New(InvincibleObjective, "Invincible!")

local extraLivesLost = 0
local enemiesWhoKilledPlayers = { }

local function EraseEnemy(type, variant, subtype)
    local freePosition = Game():GetRoom():FindFreeTilePosition(Vector.Zero, 0)
    local fakeEnemy = Isaac.Spawn(type, variant, subtype, freePosition, Vector.Zero, nil):ToNPC()
    fakeEnemy.HitPoints = 1
    local fakeEraser = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.ERASER, 0, freePosition, Vector.Zero, nil):ToTear()
    fakeEnemy.Visible = false
    fakeEraser.Visible = false
end

function InvincibleObjective:Evaluate()
    print(extraLivesLost .." >= " .. InvincibleObjective.Stats.RequiredDeath)
    return extraLivesLost >= InvincibleObjective.Stats.RequiredDeath
end

function InvincibleObjective:OnNewRun(IsContinued)
    extraLivesLost = 0
    enemiesWhoKilledPlayers = { }
end

function InvincibleObjective:OnCompleted()
    for _, enemyData in ipairs(enemiesWhoKilledPlayers) do
        EraseEnemy(enemyData[1], enemyData[2], enemyData[3])
    end
end

function InvincibleObjective:OnPlayerTakeDamage(player, amount, damageFlags, source, countdown)
    local pData = player:GetData()
    if source and source.Entity then
        if source.Entity:IsVulnerableEnemy() then
            pData.ro_invincible_lastPlayerDamageSource = { source.Entity.Type, source.Entity.Variant, source.Entity.SubType }
        end
    else
        pData.ro_invincible_lastPlayerDamageSource = nil
    end
end

function InvincibleObjective:OnPlayerUpdate(player)
    local pData = player:GetData()
    local extraLives = player:GetExtraLives()

    if pData.ro_invincible_extraLives == nil then
        pData.ro_invincible_extraLives = extraLives
    end

    if extraLives < pData.ro_invincible_extraLives then
        extraLivesLost = extraLivesLost + pData.ro_invincible_extraLives - extraLives
        if pData.ro_invincible_lastPlayerDamageSource ~= nil then
            if pData.ro_invincible_lastPlayerDamageSource.Type ~= EntityType.ENTITY_PLAYER then
                table.insert(enemiesWhoKilledPlayers, pData.ro_invincible_lastPlayerDamageSource)
            end
        end
    end

    pData.ro_invincible_extraLives = extraLives
end


function InvincibleObjective:OnPlayerUpdate_completed(player)
    local pData = player:GetData()
    local extraLives = player:GetExtraLives()

    if pData.ro_invincible_extraLives == nil then
        pData.ro_invincible_extraLives = extraLives
    end

    if extraLives < pData.ro_invincible_extraLives then
        if pData.ro_invincible_lastPlayerDamageSource ~= nil then
            if pData.ro_invincible_lastPlayerDamageSource.Type ~= EntityType.ENTITY_PLAYER then
                EraseEnemy(pData.ro_invincible_lastPlayerDamageSource[1], pData.ro_invincible_lastPlayerDamageSource[2], pData.ro_invincible_lastPlayerDamageSource[3])
            end
        end
    end

    pData.ro_invincible_extraLives = extraLives
end

-- Callbacks --
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_ENTITY_TAKE_DMG, InvincibleObjective.OnPlayerTakeDamage, EntityType.ENTITY_PLAYER)
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_POST_PEFFECT_UPDATE, InvincibleObjective.OnPlayerUpdate)

RunObjectivesAPI:AddObjectiveCallback(objective, true, ModCallbacks.MC_ENTITY_TAKE_DMG, InvincibleObjective.OnPlayerTakeDamage, EntityType.ENTITY_PLAYER)
RunObjectivesAPI:AddObjectiveCallback(objective, true, ModCallbacks.MC_POST_PEFFECT_UPDATE, InvincibleObjective.OnPlayerUpdate_completed)