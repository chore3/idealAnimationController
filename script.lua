vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)

-- ==================================================

local safeAnim = require("modules/safeAnim")
_G.stateHandler = require("modules/stateHandler")
local util = require("modules/util")

-- # 排他的なアニメーション
-- [ここにstateHandler.statesで管理している「状態」を`状態の名称 = 優先度`のように追記すると「状態」が`true`のタイミングで同名のアニメーションを自動再生することができます。]
-- [複数個の「状態」が同時に真(true)の場合、最も優先度の高い1つのみが再生されます。優先度の数値が大きいものほど優先的に再生されます。]
-- [利用可能な「状態」はREADME.mdか`log(stateHandler.states)`を実行することで確認できます。]
-- [また、`exclusiveAnimationsMap`と`customStates`の両方に任意の名称で「状態」を追記することで`stateHandler.states`の役割を拡張することができます。]
local exclusiveAnimationsMap = {
    idle = 0,
    fishing = 1,
    sprint = 2,
    walk = 3,
    crouch = 4,
    swim = 5,
    climb = 6,
    fall = 7,
    glide = 8,
    riptide = 9,
    sleep = 10,
    die = 11
}

-- # 「状態」の追加
-- [排他的なアニメーションを拡張する際に活用できます。]
-- [例えば、アクションホイールで真偽値を切り替えることで他のアニメーションを再生せずに任意のアニメーションだけを再生できます。]
_G.customStates = {
}

-- ==================================================

function events.tick()
    local exclusiveAnim = util.getHighestPriorityActivePlayableState(animations.model,
    util.mergeTable(stateHandler.states, customStates),
        exclusiveAnimationsMap)
    if exclusiveAnim == nil then
        exclusiveAnim = "idle"
    end
    for name, _ in pairs(exclusiveAnimationsMap) do
        safeAnim.setPlayIfExists(animations.model, name, name == exclusiveAnim)
    end
end

-- # stateEvents
-- [stateHandler.statesの値が真(true)になった瞬間のみ実行される関数です。]
stateHandler.onJump(function()
    safeAnim.setPlayIfExists(animations.model, "onJump", true)
end)
