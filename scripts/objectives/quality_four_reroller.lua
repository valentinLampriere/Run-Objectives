local RerollQualityFourObjective = { }

local itemConfig = Isaac.GetItemConfig()
local itemPool = Game():GetItemPool()
local d6frameUsed = 0
local hasRerolledQuality4 = false

local quality4RerollerObjective = RunObjectivesAPI.Objective:new(RerollQualityFourObjective, "Quality 4 reroller")

local game = Game()
local rng

RerollQualityFourObjective.Stats = {
    RerollChance = {
        [0] = 90,
        [1] = 75,
        [2] = 50,
        [3] = 25,
        [4] = 0
    }
}

function RerollQualityFourObjective:Evaluate()
    return hasRerolledQuality4
end

function RerollQualityFourObjective:OnNewRun(IsContinued)
    hasRerolledQuality4 = false
    d6frameUsed = 0
end

RunObjectivesAPI:RegisterObjective(quality4RerollerObjective)


local function GetCollectibleQuality(id)
    local collectible = itemConfig:GetCollectible(id)
    if collectible then
        return collectible.Quality
    end
    return 0
end

function RerollQualityFourObjective:PreUseD6_uncomplete(collectibleType, rng, player, flags, slot)
    local collectibles = Isaac.FindByType(5, 100, -1, false, false)
    for _, collectible in ipairs(collectibles) do
        local quality = GetCollectibleQuality(collectible.SubType)
        if quality == 4 then
            hasRerolledQuality4 = true
            return
        end
    end
end

function RerollQualityFourObjective:PreUseD6_complete(collectibleType, _rng, player, flags, slot)
    d6frameUsed = game:GetFrameCount()
    rng = _rng
end

local function GetPoolType(seed)
    local roomType = game:GetRoom():GetType()
    local poolType = itemPool:GetPoolForRoom(roomType, seed)
    if poolType == -1 then poolType = ItemPoolType.POOL_TREASURE end
    return poolType
end

local function TryGetBetterItem(poolType, seed, collectible)
    local quality = GetCollectibleQuality(collectible)
    local chance = RerollQualityFourObjective.Stats.RerollChance[quality]
    local roll = rng:RandomFloat() * 100

    if roll < chance then
        local newCollectible = itemPool:GetCollectible(poolType, false, seed)
        local newQuality = GetCollectibleQuality(newCollectible)

        if newQuality > quality then
            return TryGetBetterItem(poolType, seed, newCollectible)-- or newCollectible
        else
            return TryGetBetterItem(poolType, seed, collectible)
        end
    end

    return collectible
end

function RerollQualityFourObjective:OnPickupSelection(pickup, variant, subtype)
    if variant ~= PickupVariant.PICKUP_COLLECTIBLE or d6frameUsed ~= game:GetFrameCount() then
        return
    end

    local seed = rng:GetSeed()
    local poolType = GetPoolType(seed)

    local newCollectible = TryGetBetterItem(poolType, seed, subtype)

    if newCollectible ~= subtype then
        itemPool:RemoveCollectible(newCollectible)
        print("Reroll " .. subtype .. " to " .. newCollectible)
        return { variant, newCollectible }
    end
end

-- MC_PRE_USE_ITEM --
RunObjectivesAPI:AddObjectiveCallback(quality4RerollerObjective, false, ModCallbacks.MC_PRE_USE_ITEM, RerollQualityFourObjective.PreUseD6_uncomplete, CollectibleType.COLLECTIBLE_D6)
RunObjectivesAPI:AddObjectiveCallback(quality4RerollerObjective, true, ModCallbacks.MC_PRE_USE_ITEM, RerollQualityFourObjective.PreUseD6_complete, CollectibleType.COLLECTIBLE_D6)
-- MC_POST_PICKUP_SELECTION --
RunObjectivesAPI:AddObjectiveCallback(quality4RerollerObjective, true, ModCallbacks.MC_POST_PICKUP_SELECTION, RerollQualityFourObjective.OnPickupSelection)