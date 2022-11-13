local AvoidedVoidObjective = { }

AvoidedVoidObjective.Stats = {
    ChancesToStatsUp = 33
}

local objective = RunObjectivesAPI.Objective:New(AvoidedVoidObjective, "Avoided Void")

local hasAbsorbVoid = false
local hasAbsorbBlackRune = false

function AvoidedVoidObjective:Evaluate()
    return hasAbsorbVoid or hasAbsorbBlackRune
end

function AvoidedVoidObjective:OnNewRun(IsContinued)
    hasAbsorbVoid = false
    hasAbsorbBlackRune = false
end

function AvoidedVoidObjective:OnPreUseVoid(collectible, rng, player, useFlags, slot)
    local voids = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_VOID)
    if #voids > 0 then
        hasAbsorbVoid = true
    end
end

function AvoidedVoidObjective:OnUseBlackRune(card, player, useFlags)
    AvoidedVoidObjective:OnPreUseVoid(0, nil, player, useFlags)
    local blackRunes = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.RUNE_BLACK)
    if #blackRunes > 0 then
        hasAbsorbBlackRune = true
    end
end

local function StatsUp(player)
    local items = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)
    local removedItems = { }
    -- Remove items from the room
    for _, item in ipairs(items) do
        item = item:ToPickup()
        if item:IsShopItem() == false and item.SubType > 0 then
            table.insert(removedItems, item)

            item:Remove()
        end
    end

    -- Create a fake item and absorb it for the stats
    local fakeItem = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 1, Vector.Zero, Vector.Zero, player)
    fakeItem:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
    player:UseActiveItem(CollectibleType.COLLECTIBLE_VOID, UseFlag.USE_NOANIM | UseFlag.USE_NOCOSTUME | UseFlag.USE_VOID | UseFlag.USE_NOANNOUNCER)
    
    -- Respawn previously removed items
    for _, removedItem in ipairs(removedItems) do
        local newItem = Isaac.Spawn(removedItem.Type, removedItem.Variant, removedItem.SubType, removedItem.Position, Vector.Zero, nil)
        local removedSprite = removedItem:GetSprite()
        local sprite = newItem:GetSprite()
        newItem:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
        newItem:GetSprite():SetOverlayFrame(removedSprite:GetOverlayAnimation(), removedSprite:GetOverlayFrame())
    end
end

function AvoidedVoidObjective:OnPlayerUpdate(player)
    local pData = player:GetData()
    local collectibleCount = player:GetCollectibleCount()

    if pData.ro_avoidedVoid_collectibleCount == nil then
        pData.ro_avoidedVoid_collectibleCount = collectibleCount
    elseif pData.ro_avoidedVoid_collectibleCount < collectibleCount then
        if player.QueuedItem and player.QueuedItem.Item == nil then
            local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_VOID)
            local roll = rng:RandomFloat() * 100
            if roll < AvoidedVoidObjective.Stats.ChancesToStatsUp then
                StatsUp(player)
            end
            pData.ro_avoidedVoid_collectibleCount = collectibleCount
        end
    end
end

-- Callbacks --
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_PRE_USE_ITEM, AvoidedVoidObjective.OnPreUseVoid, CollectibleType.COLLECTIBLE_VOID)
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_USE_CARD, AvoidedVoidObjective.OnUseBlackRune, Card.RUNE_BLACK)

RunObjectivesAPI:AddObjectiveCallback(objective, true, ModCallbacks.MC_POST_PEFFECT_UPDATE, AvoidedVoidObjective.OnPlayerUpdate)