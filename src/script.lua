vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)

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
    walk = 1,
    crouch = 2,
    sprint = 3,
    swim = 4,
    climb = 5,
    jump = 6,
    fall = 7,
    glide = 8,
    fishing = 9,
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

if host:isHost() then require("src/host") end
require("src/both")
-- require("src/onStateEvent")

-- ==================================================

function events.tick()
    local exclusiveAnim = util.getHighestPriorityActiveState(util.mergeTable(stateHandler.states, customStates), exclusive)
    if exclusiveAnim == nil then
        exclusiveAnim = "idle"
    end
    for name, _ in pairs(exclusive) do
        safeAnim.setPlayIfExists(animations.model, name, name == exclusiveAnim)
    end

    safeAnim.setPlayIfExists(animations.skull, "skullAnim", true)
end
