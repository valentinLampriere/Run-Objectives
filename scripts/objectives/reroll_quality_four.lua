local RerollQualityFourObjectiveMod = RegisterMod("Run Objectives", 1)

local RerollQualityFourObjective = { }

local itemConfig = Isaac.GetItemConfig()
local d6frameUsed = 0
local hasRerolledQuality4 = false

local function GetCollectibleQuality(id)
    local collectible = itemConfig:GetCollectible(id)
    if collectible then
        return collectible.Quality
    end
    return 0
end

function RerollQualityFourObjective:Evaluate()
    return hasRerolledQuality4
end

function RerollQualityFourObjective:PreUseD6(collectibleType, rng, player, flags, slot)
    if RerollQualityFourObjective.isCompleted == true then

        d6frameUsed = Game():GetFrameCount()

        return
    else
        local collectibles = Isaac.FindByType(5, 100, -1, false, false)
        for _, collectible in ipairs(collectibles) do
            local quality = GetCollectibleQuality(collectible.SubType)
            if quality == 4 then
                hasRerolledQuality4 = true
                return
            end
        end
    end
end

function RerollQualityFourObjective:OnPickupSelection(pickup, variant, subtype)
    if RerollQualityFourObjective.isCompleted == false then
        return
    end
    
    if variant == PickupVariant.PICKUP_COLLECTIBLE and d6frameUsed == Game():GetFrameCount() then
        return { variant, 8 }
    end
end

RerollQualityFourObjectiveMod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, RerollQualityFourObjective.PreUseD6, CollectibleType.COLLECTIBLE_D6)
RerollQualityFourObjectiveMod:AddCallback(ModCallbacks.MC_POST_PICKUP_SELECTION, RerollQualityFourObjective.OnPickupSelection)

RunObjectivesAPI:RegisterObjective(RunObjectivesAPI.Objective:new(RerollQualityFourObjective, "Quality 4 reroller"))