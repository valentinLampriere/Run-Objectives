local UseEveryAceCardsObjective = { }

UseEveryAceCardsObjective.Stats = {
    
}

local objective = RunObjectivesAPI.Objective:new(UseEveryAceCardsObjective, "Use every \"Ace\" cards")

local hasUsedAceOfSpades = false
local hasUsedAceOfClubs = false
local hasUsedAceOfDiamonds = false
local hasUsedAceOfHearts = false

function UseEveryAceCardsObjective:Evaluate()
    return hasUsedAceOfSpades and hasUsedAceOfClubs and hasUsedAceOfDiamonds and hasUsedAceOfHearts
end

function UseEveryAceCardsObjective:OnNewRun(isCompleted)
    hasUsedAceOfSpades = false
    hasUsedAceOfClubs = false
    hasUsedAceOfDiamonds = false
    hasUsedAceOfHearts = false
end

RunObjectivesAPI:RegisterObjective(objective)


function UseEveryAceCardsObjective:UseAceOfSpaces(card, player, useFlags)
    hasUsedAceOfSpades = true
end

function UseEveryAceCardsObjective:UseAceOfClubs(card, player, useFlags)
    hasUsedAceOfClubs = true
end

function UseEveryAceCardsObjective:UseAceOfDiamonds(card, player, useFlags)
    hasUsedAceOfDiamonds = true
end

function UseEveryAceCardsObjective:UseAceOfHearts(card, player, useFlags)
    hasUsedAceOfHearts = true
end

-- Callbacks --
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_USE_CARD, UseEveryAceCardsObjective.UseAceOfSpaces, Card.CARD_ACE_OF_SPADES)
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_USE_CARD, UseEveryAceCardsObjective.UseAceOfClubs, Card.CARD_ACE_OF_CLUBS)
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_USE_CARD, UseEveryAceCardsObjective.UseAceOfDiamonds, Card.CARD_ACE_OF_DIAMONDS)
RunObjectivesAPI:AddObjectiveCallback(objective, false, ModCallbacks.MC_USE_CARD, UseEveryAceCardsObjective.UseAceOfHearts, Card.CARD_ACE_OF_HEARTS)