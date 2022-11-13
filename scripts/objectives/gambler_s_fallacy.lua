local ChestReward = include("scripts.helpers.chest_reward")

local GambersFallacyObjective = { }

GambersFallacyObjective.Stats = {
    RequiredCoinsToSpend = 100,
    DuplicateChestPickupChance = 100
}

local objective = RunObjectivesAPI.Objective:New(GambersFallacyObjective, "Gambler's Fallacy")

local spentCoins = 0

function GambersFallacyObjective:Evaluate()
    return spentCoins >= GambersFallacyObjective.Stats.RequiredCoinsToSpend
end

function GambersFallacyObjective:OnCompleted()
    local game = Game()
    local room = game:GetRoom()
    local player = Isaac.GetPlayer(0)
    local position = room:FindFreePickupSpawnPosition(player.Position, nil, true)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_CHEST, 0, position, Vector.Zero, nil)
end

function GambersFallacyObjective:OnNewRun(IsContinued)
    spentCoins = 0
end

function GambersFallacyObjective:OnMachineUpdate(machine)
    local sprite = machine:GetSprite()
    local mData = machine:GetData()
    
    local currentCountAmount = Isaac.GetPlayer(0):GetNumCoins()

    if sprite:GetFrame() == 0 then
        local animation = sprite:GetAnimation()
        if animation == "Initiate" or animation == "CoinInsert" or animation == "PayPrize" or animation == "PayNothing" or animation == "PayShuffle" then
            local previousCoinAmount = mData.ro_gamblersFallacy_previousCoinAmount or 0
            spentCoins = spentCoins + previousCoinAmount - currentCountAmount
        end
    end

    mData.ro_gamblersFallacy_previousCoinAmount = currentCountAmount
end

function GambersFallacyObjective:OnPickupUpdate(pickup)
    local sprite = pickup:GetSprite()

    if sprite:IsPlaying("Open") and sprite:GetFrame() == 1 then
        local rng = pickup:GetDropRNG()
        local roll = rng:RandomFloat() * 100

        if roll < GambersFallacyObjective.Stats.DuplicateChestPickupChance then
            ChestReward:SpawnReward(rng, pickup.Variant, pickup.Position, pickup.Velocity)
        end
    end
end

-- Callbacks --
RunObjectivesAPI:AddObjectiveCallback(objective, false, RunObjectivesAPI.ModCallbacks.MACHINE_UPDATE, GambersFallacyObjective.OnMachineUpdate)
RunObjectivesAPI:AddObjectiveCallback(objective, true, ModCallbacks.MC_POST_PICKUP_UPDATE, GambersFallacyObjective.OnPickupUpdate)

return GambersFallacyObjective