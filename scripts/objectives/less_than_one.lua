local LessThanOneObjective = { }

local game = Game()
local itemPool = game:GetItemPool()

local hasSpindownSadOnion = false
local hasSpindownSadOnionFrame = 0

local objective = RunObjectivesAPI.Objective:new(LessThanOneObjective, "Less Than One")


function LessThanOneObjective:Evaluate()
    return hasSpindownSadOnion
end

function LessThanOneObjective:OnNewRun(IsContinued)
    hasSpindownSadOnion = false
    hasSpindownSadOnionFrame = 0
end

RunObjectivesAPI:RegisterObjective(objective)

local function GetPoolType(seed)
    local roomType = game:GetRoom():GetType()
    local poolType = itemPool:GetPoolForRoom(roomType, seed)
    if poolType == -1 then poolType = ItemPoolType.POOL_TREASURE end
    return poolType
end

function LessThanOneObjective:PreUseSpindownDice(item, rng, player, useFlags, slot)
    local sadOnions = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_SAD_ONION, false, false)
    
    if #sadOnions > 0 then
        hasSpindownSadOnionFrame = game:GetFrameCount()
        hasSpindownSadOnion = true
    end
end

function LessThanOneObjective:UseSpindownDice(item, rng, player, useFlags, slot)
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


function LessThanOneObjective:OnPickupInit(pickup)
    local pedestalCycleData = CyclingItemsAPI:getPedestalCycleData(pickup.Position)
    if pedestalCycleData == nil then
        CyclingItemsAPI:addCyclingOption(pickup, { pickup.SubType - 1 })
        CyclingItemsAPI:setCyclingCooldown(pickup, 10)
    end
end

-- Callbacks --
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_PRE_USE_ITEM, LessThanOneObjective.PreUseSpindownDice, CollectibleType.COLLECTIBLE_SPINDOWN_DICE)
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_USE_ITEM, LessThanOneObjective.UseSpindownDice, CollectibleType.COLLECTIBLE_SPINDOWN_DICE)

RunObjectivesAPI:AddObjectiveCallback(objective, true, ModCallbacks.MC_POST_PICKUP_INIT, LessThanOneObjective.OnPickupInit, PickupVariant.PICKUP_COLLECTIBLE)