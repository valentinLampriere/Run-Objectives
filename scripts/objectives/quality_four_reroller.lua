local RerollQualityFourObjective = { }

local itemConfig = Isaac.GetItemConfig()
local d6frameUsed = 0
local hasRerolledQuality4 = false

local quality4RerollerObjective = RunObjectivesAPI.Objective:new(RerollQualityFourObjective, "Quality 4 reroller")

function RerollQualityFourObjective:Evaluate()
    return hasRerolledQuality4
end

function RerollQualityFourObjective:OnNewRun(isCompleted)
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
function RerollQualityFourObjective:PreUseD6_complete(collectibleType, rng, player, flags, slot)
    d6frameUsed = Game():GetFrameCount()
end

function RerollQualityFourObjective:OnPickupSelection(pickup, variant, subtype)
    if variant == PickupVariant.PICKUP_COLLECTIBLE and d6frameUsed == Game():GetFrameCount() then
        return { variant, 8 }
    end
end

-- MC_PRE_USE_ITEM --
RunObjectivesAPI:AddObjectiveCallback(quality4RerollerObjective, false, ModCallbacks.MC_PRE_USE_ITEM, RerollQualityFourObjective.PreUseD6_uncomplete, CollectibleType.COLLECTIBLE_D6)
RunObjectivesAPI:AddObjectiveCallback(quality4RerollerObjective, true, ModCallbacks.MC_PRE_USE_ITEM, RerollQualityFourObjective.PreUseD6_complete, CollectibleType.COLLECTIBLE_D6)
-- MC_POST_PICKUP_SELECTION --
RunObjectivesAPI:AddObjectiveCallback(quality4RerollerObjective, true, ModCallbacks.MC_POST_PICKUP_SELECTION, RerollQualityFourObjective.OnPickupSelection)