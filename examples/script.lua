vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)

_G.EXAMPLE_MODEL_ANIMATIONS = animations["examples.models.model"]

-- ==================================================

local safeAnim = require("modules/safeAnim")
_G.stateHandler = require("modules/stateHandler")
local util = require("modules/util")

-- # 排他的なアニメーション
-- [ここに列挙されたstateHandler.statesは複数個が同時にtrueの場合でも、最も数値の高い1つのみが再生されます。]
-- [利用可能なstateHandler.statesはREADME.mdか`log(stateHandler.states)`を実行することで確認できます。]
-- [また、exclusiveとcustomStatesの両方に新しい任意の名前を入力することでstateHandler.statesにないアニメーションを拡張できます。（例：unexpected）]
local exclusive = {
    idle = 0,
    fishing = 1,
    walk = 2,
    crouch = 3,
    sprint = 4,
    swim = 5,
    climb = 6,
    jump = 7,
    fall = 8,
    glide = 9,
    riptide = 10,
    sleep = 11,
    dye = 12,

    newExclusiveAnimation = 100
}
-- # カスタムstates
-- [排他的なアニメーションを拡張する際に活用できます。]
-- [例えば、アクションホイールで真偽値を切り替えることで他のアニメーションを再生せずに任意のアニメーションだけを再生できます。]
_G.customStates = {
    newExclusiveAnimation = false
}

if host:isHost() then require("./host") end
require("./both")
-- require("src/onStateEvent")

-- ==================================================

function events.tick()
    local exclusiveAnim = util.getHighestPriorityActiveState(util.mergeTable(stateHandler.states, customStates),
    exclusive)
    if exclusiveAnim == nil then
        exclusiveAnim = "idle"
    end
    for name, _ in pairs(exclusive) do
        safeAnim.setPlayIfExists(EXAMPLE_MODEL_ANIMATIONS, name, name == exclusiveAnim)
    end

    safeAnim.setPlayIfExists(animations["examples.models.skull"], "skullAnim", true)
end
