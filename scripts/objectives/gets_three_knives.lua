local GetsThreeKnivesObjective = { }

GetsThreeKnivesObjective.Stats = {
    RequiredKnivesNum = 3
}

local getsThreeKnivesObjectiveObjective = RunObjectivesAPI.Objective:new(GetsThreeKnivesObjective, "Gets three knives")

local game = Game()

local knivesCount = 0

function GetsThreeKnivesObjective:Evaluate()
    return knivesCount / game:GetNumPlayers() >= GetsThreeKnivesObjective.Stats.RequiredKnivesNum
end

function GetsThreeKnivesObjective:OnNewRun(IsContinued)
    knivesCount = 0

    local playerCount = game:GetNumPlayers()
    for i = 1, playerCount do
        local player = Isaac.GetPlayer(i - 1)
        GetsThreeKnivesObjective:OnPlayerInit(player)
    end
end

RunObjectivesAPI:RegisterObjective(getsThreeKnivesObjectiveObjective)

local function EvaluateKnivesItemCount(pData, variableName, _knivesCount)
    if pData[variableName] == nil then
        pData[variableName] = 0
    end
    if pData[variableName] ~= _knivesCount then
        if pData[variableName] < _knivesCount then
            knivesCount = knivesCount + (_knivesCount - pData[variableName])
        else
            knivesCount = knivesCount - (pData[variableName] - _knivesCount)
        end
        pData[variableName] = _knivesCount
    end
end

function GetsThreeKnivesObjective:OnPlayerUpdate(player)
    local pData = player:GetData()

    local hasMomsTransformation = player:HasPlayerForm(PlayerForm.PLAYERFORM_MOM)
    local momsKnivesCount = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MOMS_KNIFE, true)
    local knivesPieces1Count = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_KNIFE_PIECE_1, true)
    local knivesPieces2Count = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_KNIFE_PIECE_2, true)
    local fullKnivesCount = math.min(knivesPieces1Count, knivesPieces2Count)
    local sacrificialDaggerCount = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SACRIFICIAL_DAGGER, true)

    if pData.ro_3knives_hasButtKnife ~= hasMomsTransformation then
        if hasMomsTransformation == true then
            knivesCount = knivesCount + 1
        else
            knivesCount = knivesCount - 1
        end
        pData.ro_3knives_hasButtKnife = hasMomsTransformation
    end

    EvaluateKnivesItemCount(pData, "ro_3knives_momsKnivesCount", momsKnivesCount)
    EvaluateKnivesItemCount(pData, "ro_3knives_fullKnivesCount", fullKnivesCount)
    EvaluateKnivesItemCount(pData, "ro_3knives_sacrificalDaggersCount", sacrificialDaggerCount)
end

function GetsThreeKnivesObjective:OnPlayerInit(player)
    local pData = player:GetData()
    pData.ro_3knives_hasButtKnife = false
    pData.ro_3knives_momsKnivesCount = 0
    pData.ro_3knives_fullKnivesCount = 0
    pData.ro_3knives_sacrificalDaggersCount = 0
end

RunObjectivesAPI:AddObjectiveCallback(getsThreeKnivesObjectiveObjective, false, ModCallbacks.MC_POST_PEFFECT_UPDATE, GetsThreeKnivesObjective.OnPlayerUpdate)
RunObjectivesAPI:AddObjectiveCallback(getsThreeKnivesObjectiveObjective, false, ModCallbacks.MC_POST_PLAYER_INIT, GetsThreeKnivesObjective.OnPlayerInit)