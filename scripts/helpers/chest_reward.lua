local ChestReward = { }

ChestReward.Rewards = {
    [PickupVariant.PICKUP_CHEST] = {
        { Variant = PickupVariant.PICKUP_TRINKET,  Chance = 5 },
        { Variant = PickupVariant.PICKUP_PILL,  Chance = 5 },
        { Variant = PickupVariant.PICKUP_CHEST,  Chance = 0.5 },
        {
            Chance = 89.5,
            BatchCountMin = 1,
            BatchCountMax = 3,
            Batch = {
                { Variant = PickupVariant.PICKUP_COIN,  Chance = 35,    AmountMax = 3, AmountMin = 1 },
                { Variant = PickupVariant.PICKUP_BOMB,  Chance = 30,    Amount = 1 },
                { Variant = PickupVariant.PICKUP_KEY,   Chance = 15,    Amount = 1 },
                { Variant = PickupVariant.PICKUP_HEART, Chance = 20,    Amount = 1 }
            }
        }
    },
    [PickupVariant.PICKUP_REDCHEST] = {
        { Variant = PickupVariant.PICKUP_BOMB,  SubType = BombSubType.BOMB_TROLL,       Chance = 10,    Amount = 2 },
        { Variant = PickupVariant.PICKUP_BOMB,  SubType = BombSubType.BOMB_SUPERTROLL,  Chance = 10 },
        { Variant = PickupVariant.PICKUP_HEART, SubType = HeartSubType.HEART_SOUL,      Chance = 5,     AmountMin = 1, AmountMax = 2 },
        { Variant = PickupVariant.PICKUP_PILL,  Chance = 5, AmountMin = 1, AmountMax = 2 },
        { Type = EntityType.ENTITY_SPIDER, Chance = 13, Amount = 2 },
        { Type = EntityType.ENTITY_FAMILIAR, Variant = FamiliarVariant.BLUE_FLY, Chance = 7, Amount = 3 },
        { Type = EntityType.ENTITY_FAMILIAR, Variant = FamiliarVariant.BLUE_SPIDER, Chance = 7, Amount = 3 },
        --{ Variant = PickupVariant.PICKUP_COLLECTIBLE, Chance = 10 },
    },
    [PickupVariant.PICKUP_LOCKEDCHEST] = {
        --{ Variant = PickupVariant.PICKUP_COLLECTIBLE, Chance = 20 },
        { Variant = PickupVariant.PICKUP_TRINKET,  Chance = 10 },
        { Variant = PickupVariant.PICKUP_CHEST,  Chance = 1 },
        { Variant = PickupVariant.PICKUP_LOCKEDCHEST,  Chance = 1 },
        { Variant = PickupVariant.PICKUP_TAROTCARD,  Chance = 10 },
        {
            Chance = 58,
            BatchCountMin = 2,
            BatchCountMax = 6,
            Batch = {
                { Variant = PickupVariant.PICKUP_COIN,  Chance = 35,    AmountMax = 3, AmountMin = 1 },
                { Variant = PickupVariant.PICKUP_HEART, Chance = 20},
                { Variant = PickupVariant.PICKUP_BOMB,  Chance = 30},
                { Variant = PickupVariant.PICKUP_KEY,   Chance = 15},
            }
        }
    },
    [PickupVariant.PICKUP_BOMBCHEST] = {
        --{ Variant = PickupVariant.PICKUP_COLLECTIBLE, Chance = 20 },
        { Variant = PickupVariant.PICKUP_TRINKET,  Chance = 10 },
        { Variant = PickupVariant.PICKUP_CHEST,  Chance = 1 },
        { Variant = PickupVariant.PICKUP_LOCKEDCHEST,  Chance = 1 },
        { Variant = PickupVariant.PICKUP_TAROTCARD,  Chance = 10 },
        {
            Chance = 58,
            BatchCountMin = 2,
            BatchCountMax = 6,
            Batch = {
                { Variant = PickupVariant.PICKUP_COIN,  Chance = 35,    AmountMax = 3, AmountMin = 1 },
                { Variant = PickupVariant.PICKUP_HEART, Chance = 20},
                { Variant = PickupVariant.PICKUP_BOMB,  Chance = 30},
                { Variant = PickupVariant.PICKUP_KEY,   Chance = 15},
            }
        }
    },
    [PickupVariant.PICKUP_ETERNALCHEST] = {
        --{ Variant = PickupVariant.PICKUP_COLLECTIBLE, Chance = 20 },
        { Variant = PickupVariant.PICKUP_TRINKET,  Chance = 10 },
        { Variant = PickupVariant.PICKUP_CHEST,  Chance = 1 },
        { Variant = PickupVariant.PICKUP_LOCKEDCHEST,  Chance = 1 },
        { Variant = PickupVariant.PICKUP_TAROTCARD,  Chance = 10 },
        {
            Chance = 58,
            BatchCountMin = 2,
            BatchCountMax = 6,
            Batch = {
                { Variant = PickupVariant.PICKUP_COIN,  Chance = 35,    AmountMax = 3, AmountMin = 1 },
                { Variant = PickupVariant.PICKUP_HEART, Chance = 20},
                { Variant = PickupVariant.PICKUP_BOMB,  Chance = 30},
                { Variant = PickupVariant.PICKUP_KEY,   Chance = 15},
            }
        }
    },
    [PickupVariant.PICKUP_MIMICCHEST] = {
        { Variant = PickupVariant.PICKUP_TRINKET,  Chance = 5 },
        { Variant = PickupVariant.PICKUP_PILL,  Chance = 5 },
        { Variant = PickupVariant.PICKUP_CHEST,  Chance = 0.5 },
        {
            Chance = 89.5,
            BatchCountMin = 1,
            BatchCountMax = 3,
            Batch = {
                { Variant = PickupVariant.PICKUP_COIN,  Chance = 35,    AmountMax = 3, AmountMin = 1 },
                { Variant = PickupVariant.PICKUP_BOMB,  Chance = 30,    Amount = 1 },
                { Variant = PickupVariant.PICKUP_KEY,   Chance = 15,    Amount = 1 },
                { Variant = PickupVariant.PICKUP_HEART, Chance = 20,    Amount = 1 }
            }
        }
    },
    [PickupVariant.PICKUP_OLDCHEST] = {
        { Variant = PickupVariant.PICKUP_HEART, SubType = HeartSubType.HEART_SOUL, Chance = 43, AmountMax = 3, AmountMin = 1 },
        { Variant = PickupVariant.PICKUP_TRINKET, Chance = 42, Amount = 3 },
        --{ Variant = PickupVariant.PICKUP_COLLECTIBLE, Chance = 10 }, -- Old Chest pool
        --{ Variant = PickupVariant.PICKUP_COLLECTIBLE, Chance = 5 }, -- Angel pool
    },
    [PickupVariant.PICKUP_WOODENCHEST] = {
        { Variant = PickupVariant.PICKUP_TAROTCARD, Chance = 45, Amount = 2 },
        { Variant = PickupVariant.PICKUP_PILL, Chance = 45, AmountMax = 3, AmountMin = 2 },
        --{ Variant = PickupVariant.PICKUP_COLLECTIBLE, Chance = 10 },
    },
    [PickupVariant.PICKUP_HAUNTEDCHEST] = {
        { Variant = PickupVariant.PICKUP_TRINKET,  Chance = 5 },
        { Variant = PickupVariant.PICKUP_PILL,  Chance = 5 },
        { Variant = PickupVariant.PICKUP_CHEST,  Chance = 0.5 },
        {
            Chance = 89.5,
            BatchCountMin = 1,
            BatchCountMax = 3,
            Batch = {
                { Variant = PickupVariant.PICKUP_COIN,  Chance = 35,    AmountMax = 3, AmountMin = 1 },
                { Variant = PickupVariant.PICKUP_BOMB,  Chance = 30,    Amount = 1 },
                { Variant = PickupVariant.PICKUP_KEY,   Chance = 15,    Amount = 1 },
                { Variant = PickupVariant.PICKUP_HEART, Chance = 20,    Amount = 1 }
            }
        }
    },
    [PickupVariant.PICKUP_SPIKEDCHEST] = {
        { Variant = PickupVariant.PICKUP_TRINKET,  Chance = 5 },
        { Variant = PickupVariant.PICKUP_PILL,  Chance = 5 },
        { Variant = PickupVariant.PICKUP_CHEST,  Chance = 0.5 },
        {
            Chance = 89.5,
            BatchCountMin = 1,
            BatchCountMax = 3,
            Batch = {
                { Variant = PickupVariant.PICKUP_COIN,  Chance = 35,    AmountMax = 3, AmountMin = 1 },
                { Variant = PickupVariant.PICKUP_BOMB,  Chance = 30,    Amount = 1 },
                { Variant = PickupVariant.PICKUP_KEY,   Chance = 15,    Amount = 1 },
                { Variant = PickupVariant.PICKUP_HEART, Chance = 20,    Amount = 1 }
            }
        }
    },
}

local SpawnBehaviour = {
    [EntityType.ENTITY_SPIDER] = {
        [0] = function (type, variant, subtype, position, velocity, spawner)
            EntityNPC.ThrowSpider(position, spawner, position + velocity, false, 0)
        end
    },
    [EntityType.ENTITY_FAMILIAR] = {
        [FamiliarVariant.BLUE_FLY] = function (type, variant, subtype, position, velocity, spawner)
            local player = Isaac.GetPlayer(0)
            player:AddBlueFlies(1, position, player)
        end,
        [FamiliarVariant.BLUE_SPIDER] = function (type, variant, subtype, position, velocity, spawner)
            Isaac.GetPlayer(0):ThrowBlueSpider(position, position + velocity)
        end
    }
}

function ChestReward:GetChestReward(rng, chestVariant, chestContent)
    local rewards = { }

    chestContent = chestContent or ChestReward.Rewards[chestVariant]

    if chestContent == nil then
        print("Not a chest with rewards, or not a chest")
        return
    end

    local totalWeight = 0
    for _, chestReward in ipairs(chestContent) do
        local chance = chestReward.Chance or 0
        totalWeight = totalWeight + chance
    end

    local roll = rng:RandomFloat() * totalWeight

    for i, chestReward in ipairs(chestContent) do
        local chance = chestReward.Chance or 0
        if roll > 0 and roll - chance < 0 then
            if chestReward.Batch ~= nil then
                local amount = 0
                if chestReward.BatchCountMax ~= nil and chestReward.BatchCountMin ~= nil then
                    amount = rng:RandomInt(chestReward.BatchCountMax) + chestReward.BatchCountMin
                else
                    amount = chestReward.BatchCount or 1
                end

                for j = 1, amount do
                    local batchRewards = ChestReward:GetChestReward(rng, chestVariant, chestReward.Batch) or { }
                    for k, batchReward in ipairs(batchRewards) do
                        table.insert( rewards, batchReward )
                    end
                end
            else
                local type = chestReward.Type or 5
                local variant = chestReward.Variant or 0
                local subType = chestReward.SubType or 0

                local amount = 0
                if chestReward.AmountMax ~= nil and chestReward.AmountMin ~= nil then
                    amount = rng:RandomInt(chestReward.AmountMax - chestReward.AmountMin + 1) + chestReward.AmountMin
                else
                    amount = chestReward.Amount or 1
                end
                for j = 1, amount do
                    table.insert( rewards, { type, variant, subType } )
                end
            end
        end
        roll = roll - chance
    end

    return rewards
end

local function RandomVelocity(strength)
    strength = strength or 2
    local vector = Vector(strength, strength)
    local angle = math.random() * 360
    return vector:Rotated(angle)
end

function ChestReward:SpawnReward(rng, chestVariant, position, initialVelocity)
    initialVelocity = initialVelocity or Vector.Zero

    local rewards = ChestReward:GetChestReward(rng, chestVariant)

    if rewards == nil then
        return
    end

    for i, reward in ipairs(rewards) do
        local type = reward[1]
        local variant = reward[2]
        local subtype = reward[3]
        if SpawnBehaviour[type] ~= nil and SpawnBehaviour[type][variant] ~= nil then
            SpawnBehaviour[type][variant](type, variant, subtype, position, initialVelocity, nil)
        else
            Isaac.Spawn(type, variant, subtype, position, initialVelocity + RandomVelocity(), nil)
        end
    end
end


return ChestReward