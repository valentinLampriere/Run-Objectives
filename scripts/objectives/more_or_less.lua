local MoreOrLessObjective = { }

local game = Game()
local itemPool = game:GetItemPool()

local hasSpindownSadOnion = false
local hasSpindownSadOnionFrame = 0

local objective = RunObjectivesAPI.Objective:New(MoreOrLessObjective, "More or Less")


function MoreOrLessObjective:Evaluate()
    return hasSpindownSadOnion
end

function MoreOrLessObjective:OnNewRun(IsContinued)
    hasSpindownSadOnion = false
    hasSpindownSadOnionFrame = 0
end

local function GetPoolType(seed)
    local roomType = game:GetRoom():GetType()
    local poolType = itemPool:GetPoolForRoom(roomType, seed)
    if poolType == -1 then poolType = ItemPoolType.POOL_TREASURE end
    return poolType
end

function MoreOrLessObjective:PreUseSpindownDice(item, rng, player, useFlags, slot)
    local sadOnions = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_SAD_ONION, false, false)
    
    if #sadOnions > 0 then
        hasSpindownSadOnionFrame = game:GetFrameCount()
        hasSpindownSadOnion = true
    end
end

function MoreOrLessObjective:UseSpindownDice(item, rng, player, useFlags, slot)
    if hasSpindownSadOnionFrame == game:GetFrameCount() then
        local emptyPedestals = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, false, false)
        
        if #emptyPedestals > 0 then
            local seed = rng:GetSeed()
            local poolType = GetPoolType(seed)
            for _, emptyPedestal in ipairs(emptyPedestals) do
                emptyPedestal:Remove()
                
                local newSadOnion = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_SAD_ONION, emptyPedestal.Position, emptyPedestal.Velocity, emptyPedestal)

                CyclingItemsAPI:addCyclingOption(newSadOnion, "room")
                CyclingItemsAPI:setCyclingCooldown(newSadOnion, 10)
            end
    
            hasSpindownSadOnion = true
        end
    end
end


function MoreOrLessObjective:OnPickupInit(pickup)
    local pedestalCycleData = CyclingItemsAPI:getPedestalCycleData(pickup.Position)
    if pedestalCycleData == nil then
        CyclingItemsAPI:addCyclingOption(pickup, { pickup.SubType - 1 })
        CyclingItemsAPI:setCyclingCooldown(pickup, 10)
    end
end

-- Callbacks --
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_PRE_USE_ITEM, MoreOrLessObjective.PreUseSpindownDice, CollectibleType.COLLECTIBLE_SPINDOWN_DICE)
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_USE_ITEM, MoreOrLessObjective.UseSpindownDice, CollectibleType.COLLECTIBLE_SPINDOWN_DICE)

RunObjectivesAPI:AddObjectiveCallback(objective, true, ModCallbacks.MC_POST_PICKUP_INIT, MoreOrLessObjective.OnPickupInit, PickupVariant.PICKUP_COLLECTIBLE)