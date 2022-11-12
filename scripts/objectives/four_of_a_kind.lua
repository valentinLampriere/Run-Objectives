local FourOfAKindObjective = { }

local objective = RunObjectivesAPI.Objective:new(FourOfAKindObjective, "For of a Kind")

local hasUsedAceOfSpades = false
local hasUsedAceOfClubs = false
local hasUsedAceOfDiamonds = false
local hasUsedAceOfHearts = false

local game = Game()

function FourOfAKindObjective:Evaluate()
    return hasUsedAceOfSpades and hasUsedAceOfClubs and hasUsedAceOfDiamonds and hasUsedAceOfHearts
end

function FourOfAKindObjective:OnNewRun(IsContinued)
    hasUsedAceOfSpades = false
    hasUsedAceOfClubs = false
    hasUsedAceOfDiamonds = false
    hasUsedAceOfHearts = false
end

RunObjectivesAPI:RegisterObjective(objective)


function FourOfAKindObjective:UseAceOfSpaces(card, player, useFlags)
    hasUsedAceOfSpades = true
end

function FourOfAKindObjective:UseAceOfClubs(card, player, useFlags)
    hasUsedAceOfClubs = true
end

function FourOfAKindObjective:UseAceOfDiamonds(card, player, useFlags)
    hasUsedAceOfDiamonds = true
end

function FourOfAKindObjective:UseAceOfHearts(card, player, useFlags)
    hasUsedAceOfHearts = true
end


function FourOfAKindObjective:OnCardUpdate(card)
    local pData = card:GetData()
    local sprite = card:GetSprite()

    if pData.ro_fourOfAKind_isInit == nil then
        if pData.ro_fourOfAKind_isCopyCard == nil and sprite:IsPlaying("Appear") then
            local position = game:GetRoom():FindFreePickupSpawnPosition(card.Position, 0, true)
            local newCard = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, 0, position, card.Velocity, nil)
            local _pData = newCard:GetData()
            _pData.ro_fourOfAKind_isCopyCard = true
        end
        pData.ro_fourOfAKind_isInit = true
    end
end

-- Callbacks --
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_USE_CARD, FourOfAKindObjective.UseAceOfSpaces, Card.CARD_ACE_OF_SPADES)
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_USE_CARD, FourOfAKindObjective.UseAceOfClubs, Card.CARD_ACE_OF_CLUBS)
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_USE_CARD, FourOfAKindObjective.UseAceOfDiamonds, Card.CARD_ACE_OF_DIAMONDS)
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_USE_CARD, FourOfAKindObjective.UseAceOfHearts, Card.CARD_ACE_OF_HEARTS)

RunObjectivesAPI:AddObjectiveCallback(objective, true, ModCallbacks.MC_POST_PICKUP_UPDATE, FourOfAKindObjective.OnCardUpdate, PickupVariant.PICKUP_TAROTCARD)