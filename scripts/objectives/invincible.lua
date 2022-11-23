local InvincibleObjective = { }

InvincibleObjective.Stats = {
    RequiredDeath = 1
}

local objective = RunObjectivesAPI.Objective:New(InvincibleObjective, "Invincible!")

local extraLivesLost = 0
local enemiesToErase = { }

local function SpawnFakeNPC(position, type, variant, subtype)
    local fakeEnemy = Isaac.Spawn(type, variant, subtype, position, Vector.Zero, nil):ToNPC()
    fakeEnemy:AddEntityFlags(EntityFlag.FLAG_NO_STATUS_EFFECTS | EntityFlag.FLAG_NO_BLOOD_SPLASH | EntityFlag.FLAG_NO_FLASH_ON_DAMAGE | EntityFlag.FLAG_NO_KNOCKBACK | EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK | EntityFlag.FLAG_DONT_COUNT_BOSS_HP | EntityFlag.FLAG_HIDE_HP_BAR | EntityFlag.FLAG_NO_REWARD | EntityFlag.FLAG_NO_PLAYER_CONTROL | EntityFlag.FLAG_NO_QUERY)

    fakeEnemy:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
    
    fakeEnemy.HitPoints = 1
    fakeEnemy.CanShutDoors = false
    fakeEnemy.Visible = false

    return fakeEnemy
end

local function SpawnFakeEraser(position)
    local fakeEraser = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.ERASER, 0, position, Vector.Zero, nil):ToTear()
    fakeEraser:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
    fakeEraser.Visible = false

    return fakeEraser
end

local function EraseEnemy(type, variant, subtype)
    local room = Game():GetRoom()
    local centerPosition = room:GetCenterPos()
    local freePosition = room:FindFreeTilePosition(centerPosition, 0)
    local fakeEnemy = SpawnFakeNPC(freePosition, type, variant, subtype or 0)
    local fakeEraser = SpawnFakeEraser(freePosition)
end

function InvincibleObjective:Evaluate()
    return extraLivesLost >= InvincibleObjective.Stats.RequiredDeath
end

function InvincibleObjective:OnNewRun(IsContinued)
    extraLivesLost = 0
    enemiesToErase = { }
end

function InvincibleObjective:OnCompleted()
    for _, enemyData in ipairs(enemiesToErase) do
        EraseEnemy(enemyData[1], enemyData[2], enemyData[3])
    end

    enemiesToErase = { }
end

function InvincibleObjective:OnPlayerTakeDamage(player, amount, damageFlags, source, countdown)
    local pData = player:GetData()
    pData.ro_invincible_lastPlayerDamageSource = nil
    if source and source.Entity then
        if source.Entity.Type == EntityType.ENTITY_PROJECTILE then
            pData.ro_invincible_lastPlayerDamageSource = { source.Entity.SpawnerType, source.Entity.SpawnerVariant }
        elseif source.Entity:IsVulnerableEnemy() then
            pData.ro_invincible_lastPlayerDamageSource = { source.Entity.Type, source.Entity.Variant }
        end
    end
end

local function OnPlayerDied(player)
    local pData = player:GetData()
    if pData.ro_invincible_lastPlayerDamageSource.Type ~= EntityType.ENTITY_PLAYER then
        table.insert(enemiesToErase, pData.ro_invincible_lastPlayerDamageSource)
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
            OnPlayerDied(player)
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